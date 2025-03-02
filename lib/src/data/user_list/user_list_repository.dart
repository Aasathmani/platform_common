import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:platform_common/src/application/sync/syncable.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';
import 'package:platform_common/src/data/database/user_list/user_create_dao.dart';
import 'package:platform_common/src/data/database/user_list/user_list_dao.dart';
import 'package:platform_common/src/data/user_list/user_list_service.dart';
import 'package:platform_common/src/utils/extensions.dart';
import 'package:platform_common/src/utils/guard.dart';
import 'package:platform_common/src/utils/sync/job_util.dart';
import 'package:uuid/uuid.dart';

class UserListRepository implements SyncAble {
  static UserListRepository? instance;
  final UserListService userListService;
  final UserListDao userListDao;
  final JobUtils jobUtils;
  final UserCreateDao userCreateDao;

  UserListRepository({
    required this.userListService,
    required this.userListDao,
    required this.jobUtils,
    required this.userCreateDao,
  });

  Future<List<UserList>?>? getUserList(int page) async {
    await Guard.asNullableAsync(() async {
      final dataFromResponse = await userListService.fetchUserList(page);

      if (dataFromResponse.isNotEmpty) {
        final userList = toGenericMapList(dataFromResponse['data'])
            .map((item) => _toUserList(item))
            .nonNulls
            .toList();
        await userListDao.deleteProjectLists();
        await userListDao.saveProjectLists(userList);
      }
    });
    return userListDao.getBaitCategoryList();
  }

  Future<bool?> getCreateUser(
    String? name,
    String? job,
    bool networkFoundStatus,
  ) async {
    if (networkFoundStatus == true) {
      final data = {"name": name, "job": job};
      final dataFromResponse = await userListService.fetchCreateUser(data);
      return dataFromResponse;
    } else {
      try {
        final String uuid = const Uuid().v1();
        await userCreateDao.saveUserCreates(
          [
            _toUserCreate(
              id: uuid,
              name: name!,
              job: job!,
              syncStatus: SyncStatus.kCreated,
            ),
          ],
        );
        final savedResponse = await userCreateDao.getUserCreateById(uuid);
        if (savedResponse != null) {
          await jobUtils.scheduleJob(
            kSubmitUserCreate,
            savedResponse.id,
          );
        }
      } catch (e) {
        debugPrint('#############exception : $e');
        rethrow;
      }
      return true;
    }
  }

  UserCreate _toUserCreate({
    required String id,
    required String name,
    required String job,
    required String? syncStatus,
  }) {
    return UserCreate(
      id: id,
      name: name,
      job: job,
      submitAssetDeleteSyncStatus: syncStatus,
    );
  }

  @override
  Future<void> onRetryExhausted(String recordId) async {
    final record = await userCreateDao.getUserCreateById(recordId);
    if (record == null) return;

    final UserCreate item = record.copyWith(
      submitAssetDeleteSyncStatus: Value(
        SyncAble.getSyncRetryExhaustedStatus(
          record.submitAssetDeleteSyncStatus,
        ),
      ),
    );
    await userCreateDao.saveUserCreates([item]);
  }

  @override
  Future<void> resetExhausted() async {
    final list = await userCreateDao.getExhaustedConsumptionList();
    for (final item in list) {
      retrySync(item.id);
    }
  }

  @override
  Future<void> retrySync(String recordId) async {
    final record = await userCreateDao.getUserCreateById(recordId);

    if (record == null) return;
    await jobUtils.scheduleJob(
      kSubmitUserCreate,
      record.id,
    );
    }

  @override
  Future<void> syncPendingItems(String recordId) async {
    final userCreate = await userCreateDao.getUserCreateById(recordId);
    if (userCreate == null) return;
    bool? successDate;
    try {
      final data = {"name": userCreate.name, "job": userCreate.job};
      successDate = await userListService.fetchCreateUser(
        data,
      );
      if (successDate == true) {
        await userCreateDao.updateUserCreateStatus(
          userCreate.id,
          SyncStatus.kSynced,
        );
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
    return;
    }
}

UserList? _toUserList(Map<String, dynamic> item) {
  return Guard.asNullable<UserList>(() {
    return UserList(
      id: item['id'].toString(),
      email: item['email'].toString(),
      firstName: item['first_name'].toString(),
      lastName: item['last_name'].toString(),
      avatar: item['avatar'].toString(),
    );
  });
}
