// web.dart
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:drift/web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';

AppDatabase constructDb() {
  try {
    return AppDatabase(_connectOnWeb());
  } catch (e) {
    debugPrint("alternate DB $e");
    return AppDatabase(
      LazyDatabase(() async {
        final storage = await DriftWebStorage.indexedDbIfSupported('db');
        return WebDatabase.withStorage(storage);
      }),
    );
  }
}

DatabaseConnection _connectOnWeb() {
  return DatabaseConnection.delayed(
    Future(() async {
      final result = await WasmDatabase.open(
        databaseName: 'db', // prefer to only use valid identifiers here
        sqlite3Uri: Uri.parse('sql-wasm.wasm'),
        driftWorkerUri: Uri.parse('sql-wasm.js'),
        initializeDatabase: () async {
          final data = await rootBundle.load('db');
          return data.buffer.asUint8List();
        },
      );
      if (result.missingFeatures.isNotEmpty) {
        // Depending how central local persistence is to your app, you may want
        // to show a warning to the user if only unreliable implementations
        // are available.
        debugPrint(
            'Using ${result.chosenImplementation} due to missing browser '
            'features: ${result.missingFeatures}');
      }

      return result.resolvedExecutor;
    }),
  );
}
