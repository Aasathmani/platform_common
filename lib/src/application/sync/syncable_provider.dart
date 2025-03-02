import 'package:platform_common/src/application/sync/syncable.dart';
import 'package:platform_common/src/core/exceptions.dart';
import 'package:platform_common/src/data/core/repository_provider.dart';

/// Created by Jemsheer K D on 21 February, 2025.
/// File Name : syncable_provider
/// Project : Maridock

class SyncableProvider {
  static SyncableProvider? instance;

  factory SyncableProvider() {
    return instance ??= SyncableProvider._();
  }

  SyncableProvider._();

  SyncAble getRepository(String type) {
    switch (type) {
      case kSubmitUserCreate:
        return provideUserListRepository();
      /*case kBasicDetailsJob:
        return provideBasicDetailRepository();*/

      /*case kReimbursementOnBoardJob:
        return provideReimbursementRepository();*/
      default:
        throw CustomException(
          'SYNC_ERROR',
          message: '$type not Implemented',
        );
    }
  }

  List<SyncAble> getAllRepositories() {
    return [
      provideUserListRepository(),
      // provideBasicDetailRepository(),
    ];
  }
}
