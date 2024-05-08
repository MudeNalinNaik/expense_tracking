import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Expanses'),
      ),
      body: const Column(
        children: <Widget>[
          ListTile(
            title: Text('320 rs'),
            subtitle: Text('Groccesories'),
          ),
          ListTile(
            title: Text('180 rs'),
            subtitle: Text('Eggs'),
          ),
          ListTile(
            title: Text('250 rs'),
            subtitle: Text('Chicken'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => StatefulBuilder(
                  builder: (context, setState) {
                    DateTime selectedDate = DateTime.now();
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
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(Icons.monetization_on),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
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
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
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
                                      onTap: () {

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
                                      },
                                      child: Text(
                                        "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2,'0')}-${selectedDate.day.toString().padLeft(2,'0')}",
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
                                Navigator.pop(context);
                              },
                              child: const Text('Okay'))
                        ],
                      );
                }
              ));
        },
        tooltip: 'Add New',
        child: const Icon(Icons.add),
      ),
    );
  }
}
