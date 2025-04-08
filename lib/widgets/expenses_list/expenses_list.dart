import 'package:flutter/material.dart';
import 'package:expenses_tracker/widgets/expense.dart';
import 'package:expenses_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(shrinkWrap: true,
      itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index]),
      ),
      itemCount: expenses.length,
      
    );
  }
} 