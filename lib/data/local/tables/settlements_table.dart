import 'package:drift/drift.dart';

import 'trips_table.dart';
import 'users_table.dart';

/// Separate records of money paid back. Never edits original expenses.
class Settlements extends Table {
  TextColumn get id => text()();
  TextColumn get tripId =>
      text().references(Trips, #id, onDelete: KeyAction.cascade)();
  TextColumn get fromUserId => text().references(Users, #id)();
  TextColumn get toUserId => text().references(Users, #id)();
  IntColumn get amount => integer()(); // minor units
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}