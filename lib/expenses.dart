import 'package:expense_tracker/chart/chart.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import "package:flutter/material.dart";
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/widget/expense_list.dart';
import 'package:expense_tracker/main.dart';

class Expense extends StatefulWidget {
  const Expense({super.key, required this.darkButton});

  final void Function() darkButton;
  @override
  State<Expense> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expense> {
  final List<Expenses> _registerExpense = [
    Expenses(
      title: "Friends",
      amount: 200,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expenses(
      title: "Mouse",
      amount: 250,
      date: DateTime.now(),
      category: Category.work,
    )
  ];
  void addButtonLogic() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Theme(
        data: Theme.of(context),
        child: NewExpense(addExpense: _addExpense),
      ),
    );
  }

  void _addExpense(Expenses expense) {
    setState(() {
      _registerExpense.add(expense);
    });
  }

  void removeExpense(Expenses expense) {
    final expenseIndex = _registerExpense.indexOf(expense);
    setState(() {
      _registerExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registerExpense.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    MediaQuery.of(context).size.width;
    Widget mainContent = Center(
      child: Text(
        'No Expenses Found! ',
        style: isDark
            ? TextStyle(color: Colors.white)
            : TextStyle(color: Colors.black),
      ),
    );

    if (_registerExpense.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registerExpense,
        onremoveExpense: removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expense Tracker! '),
        actions: [
          IconButton(
            onPressed: widget.darkButton,
            icon: isDark
                ? Icon(Icons.dark_mode_outlined)
                : Icon(Icons.light_mode_outlined),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: addButtonLogic,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registerExpense),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
