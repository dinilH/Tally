import 'package:drift/drift.dart';

import 'trips_table.dart';

class Expenses extends Table {
  TextColumn get id => text()();
  TextColumn get tripId =>
      text().references(Trips, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text().withLength(min: 1, max: 200)();

  /// Total in minor units (cents). Always an int, never a double.
  IntColumn get totalAmount => integer()();

  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}