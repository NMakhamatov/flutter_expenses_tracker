import 'package:flutter/material.dart';
import 'package:expenses_tracker/widgets/expense.dart';

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  var _titleController = TextEditingController();
  var _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0.0;
    if (_titleController.text
        .trim()
        .isEmpty || amountIsInvalid || _selectedDate == null) {
      showDialog(context: context, builder: (ctx) =>
          AlertDialog(
            title: const Text('Invalid input'),
            content: const Text(
                'Please make sure a valid title, amount, date and category was entered.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text('Okay'),
              )
            ],
          ));

      return;
    }

    Expense expense = Expense(title: _titleController.text, amount: enteredAmount, date: _selectedDate!, category: _selectedCategory);
    widget.onAddExpense(expense);
    Navigator.pop(context);
}

void _presentDatePicker() async {
  final now = DateTime.now();
  final firstDate = DateTime(now.year - 1, now.month, now.day);
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: firstDate,
    lastDate: now,
  );

  setState(() {
    _selectedDate = pickedDate;
  });
}

@override
Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16,48,16,16),
    child: Column(
      children: [
        TextField(
          controller: _titleController,
          maxLength: 50,
          decoration: InputDecoration(label: Text('Title')),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixText: '\$ ',
                  label: Text('Amount'),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No date selected'
                        : formatter.format(_selectedDate!),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_month),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16,),

        Row(
          // todo add button to save amount
          children: [
            DropdownButton(
              value: _selectedCategory,
              items:
              Category.values
                  .map(
                    (category) =>
                    DropdownMenuItem(
                      value: category,
                      child: Text(category.name.toString().toUpperCase()),
                    ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  if (value == null) {
                    return;
                  }
                  _selectedCategory = value;
                });
              },
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _submitExpenseData,
              child: const Text('Save expense'),
            ),
          ],
        ),
      ],
    ),
  );
}}
