import 'package:drift/drift.dart';

import 'users_table.dart';

class Trips extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get currency => text().withDefault(const Constant('LKR'))();
  TextColumn get createdBy => text().references(Users, #id)();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}