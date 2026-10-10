import 'package:drift/drift.dart';

import 'expenses_table.dart';
import 'users_table.dart';

/// Who CONSUMED an expense, and each person's share.
class ExpenseShares extends Table {
  TextColumn get expenseId =>
      text().references(Expenses, #id, onDelete: KeyAction.cascade)();
  TextColumn get userId => text().references(Users, #id)();
  IntColumn get amount => integer()(); // minor units

  @override
  Set<Column> get primaryKey => {expenseId, userId};
}