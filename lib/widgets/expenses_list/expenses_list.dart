import 'package:flutter/material.dart';
import 'package:expenses_tracker/widgets/expense.dart';
import 'package:expenses_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(shrinkWrap: true,
      itemBuilder: (ctx, index) => ExpenseItem(expenses[index]),
      itemCount: expenses.length,
      
    );
  }
} 