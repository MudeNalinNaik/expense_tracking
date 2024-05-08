import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../domains/expence_domain.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();
  final moneyController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  List<Expense> expenses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Expanses'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (int a = 0; a < expenses.length; a++)
              ListTile(
                title: Text(expenses[a].money),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(expenses[a].title),
                    Text(
                        "${expenses[a].date.year.toString()}-${expenses[a].date.month.toString().padLeft(2, '0')}-${expenses[a].date.day.toString().padLeft(2, '0')}"),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addItem();
        },
        tooltip: 'Add New',
        child: const Icon(Icons.add),
      ),
    );
  }

  addItem() {
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Expanded(flex: 1, child: Text('Money : ')),
                        Expanded(
                            flex: 3,
                            child: TextField(
                              controller: moneyController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.monetization_on),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                hintStyle: const TextStyle(color: Colors.grey),
                                hintText: "Type in your text",
                                fillColor: Colors.white70,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(flex: 1, child: Text('Title : ')),
                        Expanded(
                            flex: 3,
                            child: TextField(
                              controller: titleController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                hintStyle: const TextStyle(color: Colors.grey),
                                hintText: "Type in your text",
                                fillColor: Colors.white70,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(flex: 1, child: Text('Date : ')),
                        Expanded(
                            flex: 3,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.blue),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {

                        setState(() {
                          expenses.add(Expense(
                              title: titleController.text,
                              money: moneyController.text,
                              date: DateTime.now()));
                          titleController.clear();
                          moneyController.clear();
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Okay')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                ],
              );
            }));
  }
}
