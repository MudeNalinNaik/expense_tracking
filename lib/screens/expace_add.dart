import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpenseDialog extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final VoidCallback onSubmit;
  final TextEditingController moneyController;
  final TextEditingController titleController;

  const AddExpenseDialog({
    super.key,
    required this.selectedDate,
    required this.titleController,
    required this.moneyController,
    required this.onDateChanged,
    required this.onSubmit,
  });

  @override
  _AddExpenseDialogState createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text('Money : '),
            ),
            Expanded(
              flex: 3,
              child: TextField(
                controller: widget.moneyController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text('Title : '),
            ),
            Expanded(
              flex: 3,
              child: TextField(
                controller: widget.titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: "Type in your text",
                  fillColor: Colors.white70,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text('Date : '),
            ),
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: _selectDate,
                child: Text(
                  "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
        ButtonBar(
          children: [
            TextButton(
              onPressed: widget.onSubmit,
              child: const Text('Okay'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ],
    );
  }

  void _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      widget.onDateChanged(pickedDate);
    }
  }
}
