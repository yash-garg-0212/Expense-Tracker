import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/main.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});

  final void Function(Expenses expense) addExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submittingExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final isInvalidAmount = (enteredAmount == null || enteredAmount <= 0);

    if (isInvalidAmount ||
        selectedDate == null ||
        _titleController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Data'),
          content: const Text(
              'Please make sure Inputed data is valid otherwise you will not be able to submit it'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }

    widget.addExpense(
      Expenses(
          title: _titleController.text,
          amount: enteredAmount,
          date: selectedDate!,
          category: selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16,50,16,16),
      child: Column(
        children: [
          TextField(
            style: isDark?TextStyle(color: Colors.white):TextStyle(color: Colors.black),
            controller: _titleController,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
            maxLength: 30,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: isDark?TextStyle(color: Colors.white):TextStyle(color: Colors.black),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\u{20B9}',
                    label: Text('amount'),
                  ),
                  maxLength: 5,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selectedDate == null
                          ? 'No date selected'
                          : formatter.format(selectedDate!),
                      style: isDark?TextStyle(color: Colors.white):TextStyle(color: Colors.black),
                    ),
                    IconButton(
                      onPressed: () async {
                        final currentDate = DateTime.now();
                        final firstDate = DateTime(currentDate.year - 1,
                            currentDate.month, currentDate.day);

                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: currentDate,
                          firstDate: firstDate,
                          lastDate: currentDate,
                        );
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              DropdownButton(
                value: selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name, style: isDark?TextStyle(color: Colors.white):TextStyle(color: Colors.black),),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _submittingExpense,
                child: Text('Save amount'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancle'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
