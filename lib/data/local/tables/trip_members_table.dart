import 'package:drift/drift.dart';

import 'trips_table.dart';
import 'users_table.dart';

class TripMembers extends Table {
  TextColumn get tripId =>
      text().references(Trips, #id, onDelete: KeyAction.cascade)();
  TextColumn get userId => text().references(Users, #id)();
  DateTimeColumn get joinedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {tripId, userId};
}