import 'package:expense_tracker/widget/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense_model.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenses, required this.onremoveExpense});

  final List<Expenses> expenses;
  final void Function(Expenses expense) onremoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
        return Dismissible(key: ValueKey(expenses[index]),
        background: Container(color: Theme.of(context).colorScheme.error,),
        child: ExpenseItem(expenses[index]),
        onDismissed: (direction){
          onremoveExpense(expenses[index]);
        },);
      },
    );
  }
}
