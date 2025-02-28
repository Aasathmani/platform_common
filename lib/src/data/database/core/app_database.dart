import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:platform_common/src/data/database/auth_token_dao.dart';
import 'package:platform_common/src/data/database/core/shared_db.dart';
import 'package:platform_common/src/data/database/job_dao.dart';
import 'package:platform_common/src/data/database/movie_description/movie_description_dao.dart';
import 'package:platform_common/src/data/database/movie_list/movie_list_dao.dart';
import 'package:platform_common/src/data/database/notification_dao.dart';
import 'package:platform_common/src/data/database/user_dao.dart';
import 'package:platform_common/src/data/database/user_list/user_list_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    AuthTokens,
    Notifications,
    Jobs,
    UserLists,
    MovieLists,
    MovieDescriptions,
  ],
  daos: [
    UserDao,
    AuthTokenDao,
    NotificationDao,
    JobDao,
    UserListDao,
    MovieListDao,
    MovieDescriptionDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  static AppDatabase? _instance;

  factory AppDatabase.instance() {
    return _instance ??= constructDb();
  }

  @override
  int get schemaVersion => 1;

  Future deleteAll() async {
    final m = createMigrator();
    // Going through tables in reverse because they are sorted for foreign keys
    for (final table in allTables.toList().reversed) {
      await m.deleteTable(table.actualTableName);
    }
  }

  Future recreateTables() async {
    final m = createMigrator();
    await m.createAll();
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) {
          return m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          await transaction(() async {
            try {
              // await migrationTo2(from, m); //1.0.0
            } catch (e) {
              await _deleteTables(m);
              rethrow;
            }
          });
        },
        beforeOpen: (details) async {},
      );

  Future<void> _deleteTables(Migrator m) async {
    // allSchemaEntities are sorted topologically references between them.
    // Reverse order for deletion in order to not break anything.
    final reverseTables = _instance!.allTables.toList().reversed;
    for (final table in reverseTables) {
      await m.deleteTable(table.actualTableName);
    }
    // Re-create them now
    // await m.createAll();
  }

/*
  Future<void> migrationTo27(int from, Migrator m) async {
    await _addTableMigration(
      from,
      m,
      tableFrom: 13,
      tableTo: 27,
      table: m10FamilyPersonalMedicalInsurances,
      columns: [m10FamilyPersonalMedicalInsurances.answers],
    );

    if (from < 27) {
      await m.createTable(appraisals);
    }
  }*/

  Future<void> _addTableMigration(
    int from,
    Migrator m, {
    int? tableFrom,
    required int tableTo,
    required TableInfo<Table, dynamic> table,
    required List<GeneratedColumn> columns,
  }) async {
    try {
      if ((tableFrom == null || from >= tableFrom) && from < tableTo) {
        for (final column in columns) {
          await m.addColumn(table, column);
        }
      }
    } catch (e) {
      await m.alterTable(TableMigration(table));
      debugPrint(e.toString());
    }
  }

  Future<void> clearUserRelatedTables() async {
    for (final table in userRelatedTables) {
      await delete(table).go();
    }
  }

  List<TableInfo> get userRelatedTables => [
        users,
        authTokens,
        notifications,
        jobs,
        userLists,
        movieLists,
        movieDescriptions,
      ];
}
