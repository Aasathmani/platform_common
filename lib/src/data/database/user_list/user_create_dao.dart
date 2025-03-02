import 'package:drift/drift.dart';
import 'package:platform_common/src/application/sync/syncable.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';

part 'user_create_dao.g.dart';

@DriftAccessor(tables: [UserCreates])
class UserCreateDao extends DatabaseAccessor<AppDatabase>
    with _$UserCreateDaoMixin {
  UserCreateDao(super.attachedDatabase);

  Future<void> saveUserCreates(List<UserCreate> userCreate) {
    return batch(
      (batch) => batch.insertAll(
        userCreates,
        userCreate,
        mode: InsertMode.insertOrReplace,
      ),
    );
  }

  Future<void> deleteUserCreates() async {
    await delete(userCreates).go();
  }

  Future<List<UserCreate>> getUserCreates() async {
    return select(userCreates).get();
  }

  Stream<List<UserCreate>> watchUserCreate() {
    return select(userCreates).watch();
  }

  Future<UserCreate?>? getUserCreateById(String uuid) async {
    return (select(userCreates)
          ..where((item) => item.id.equals(uuid))
          ..limit(1))
        .getSingleOrNull();
  }

  Future updateUserCreateStatus(
    String uuid,
    String? submitFormSyncStatus,
  ) {
    return (update(userCreates)..where((table) => table.id.equals(uuid))).write(
      UserCreatesCompanion(
        submitAssetDeleteSyncStatus: Value(submitFormSyncStatus),
      ),
    );
  }

  Future<void> deleteUserCreate(String uuid) async {
    await (delete(userCreates)..where((tbl) => tbl.id.equals(uuid))).go();
  }

  Future<List<UserCreate>> getExhaustedConsumptionList() async {
    return (select(userCreates)
          ..where(
            (item) => item.submitAssetDeleteSyncStatus.isIn([
              SyncStatus.kCreatedSyncRetryExhausted,
              // SyncStatus.kUpdatedSyncRetryExhausted,
            ]),
          ))
        .get();
  }
}

@DataClassName('UserCreate')
class UserCreates extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get job => text()();

  TextColumn get submitAssetDeleteSyncStatus => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
