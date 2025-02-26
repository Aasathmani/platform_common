import 'package:drift/drift.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';

part 'user_list_dao.g.dart';

@DriftAccessor(tables: [UserLists])
class UserListDao extends DatabaseAccessor<AppDatabase>
    with _$UserListDaoMixin {
  UserListDao(super.attachedDatabase);

  Future<void> saveProjectLists(List<UserList> userList) {
    return batch(
          (batch) => batch.insertAll(
        userLists,
        userList,
        mode: InsertMode.insertOrReplace,
      ),
    );
  }

  Future<void> deleteProjectLists() async {
    await delete(userLists).go();
  }

  Future<List<UserList>> getBaitCategoryList() async {
    return select(userLists).get();
  }
}

@DataClassName('UserList')
class UserLists extends Table {
  TextColumn get id => text()();

  TextColumn get email => text().nullable()();
  TextColumn get firstName => text().nullable()();
  TextColumn get lastName => text().nullable()();
  TextColumn get avatar => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}