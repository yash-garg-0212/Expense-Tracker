import 'package:expense_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expenses, {super.key});

  final Expenses expenses;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expenses.title, style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  ('\u{20B9}${expenses.amount.toStringAsFixed(2)}'),
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expenses.category]),
                    const SizedBox(width: 8,),
                    Text(formatter.format(expenses.date)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
