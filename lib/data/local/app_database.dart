import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/users_table.dart';
import 'tables/trips_table.dart';
import 'tables/trip_members_table.dart';
import 'tables/expenses_table.dart';
import 'tables/expense_payers_table.dart';
import 'tables/expense_shares_table.dart';
import 'tables/settlements_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    Trips,
    TripMembers,
    Expenses,
    ExpensePayers,
    ExpenseShares,
    Settlements,
  ],
  // DAOs get added here in the next step
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// For tests: pass an in-memory executor.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async => m.createAll(),
    beforeOpen: (details) async {
      // Makes SQLite enforce references and cascade deletes
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'tally_db',
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}