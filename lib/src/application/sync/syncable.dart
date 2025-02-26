/// Created by Jemsheer K D on 21 February, 2025.
/// File Name : syncable
/// Project : Maridock
library;

abstract class SyncAble {
  Future<void> syncPendingItems(String userId, String recordId);

  Future<void> onRetryExhausted(String userId, String recordId);

  Future<void> retrySync(String recordId);

  Future<void> resetExhausted();

  static String? getSyncRetryExhaustedStatus(String? status) {
    if ([
      SyncStatus.kCreated,
      SyncStatus.kCreatedSyncRetryExhausted,
    ].contains(status)) {
      return SyncStatus.kCreatedSyncRetryExhausted;
    } else if ([
      SyncStatus.kUpdated,
      SyncStatus.kUpdatedSyncRetryExhausted,
    ].contains(status)) {
      return SyncStatus.kUpdatedSyncRetryExhausted;
    }
    return status;
  }
}

class SyncStatus {
  SyncStatus._();

  static const String kDrafted = 'drafted';
  static const String kCreated = 'created';
  static const String kCreateInitiated = 'create_initiated';
  static const String kUpdated = 'updated';
  static const String kUpdateInitiated = 'update_initiated';
  static const String kSynced = 'synced';
  static const String kCreatedSyncRetryExhausted =
      'created_sync_retry_exhausted';
  static const String kUpdatedSyncRetryExhausted =
      'updated_sync_retry_exhausted';
  static const String kDeleted = 'deleted';
}

const kBasicDetailsJob = 'basic_details';
