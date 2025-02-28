import 'package:platform_common/src/data/database/core/app_database.dart';
import 'package:platform_common/src/data/database/user_list/user_list_dao.dart';
import 'package:platform_common/src/data/user_list/user_list_service.dart';
import 'package:platform_common/src/utils/extensions.dart';
import 'package:platform_common/src/utils/guard.dart';

class UserListRepository {
  static UserListRepository? instance;
  final UserListService userListService;
  final UserListDao userListDao;

  UserListRepository({
    required this.userListService,
    required this.userListDao,
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
