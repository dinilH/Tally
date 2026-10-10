import 'package:drift/drift.dart';

import 'expenses_table.dart';
import 'users_table.dart';

/// Who PAID for an expense, and how much each person put in.
class ExpensePayers extends Table {
  TextColumn get expenseId =>
      text().references(Expenses, #id, onDelete: KeyAction.cascade)();
  TextColumn get userId => text().references(Users, #id)();
  IntColumn get amount => integer()(); // minor units

  @override
  Set<Column> get primaryKey => {expenseId, userId};
}