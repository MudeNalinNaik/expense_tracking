import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../domains/expence_domain.dart';
import 'expace_add.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();
  final moneyController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  List<Expense> expenses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Expenses'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (int a = 0; a < expenses.length; a++)
              ListTile(
                title: Text(
                  "₹ ${expenses[a].money}",
                  style: const TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      expenses[a].title,
                      style: const TextStyle(
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${expenses[a].date.year}-${expenses[a].date.month.toString().padLeft(2, '0')}-${expenses[a].date.day.toString().padLeft(2, '0')}",
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog();
        },
        tooltip: 'Add New',
        child: const Icon(Icons.add),
      ),
    );
  }

  _showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: AddExpenseDialog(
          moneyController: moneyController,
          titleController: titleController,
          selectedDate: selectedDate,
          onDateChanged: (DateTime date) {
            setState(() {
              selectedDate = date;
            });
          },
          onSubmit: () {
            setState(() {
              expenses.add(Expense(
                title: titleController.text,
                money: moneyController.text,
                date: selectedDate,
              ));
              titleController.clear();
              moneyController.clear();
              selectedDate = DateTime.now();
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

