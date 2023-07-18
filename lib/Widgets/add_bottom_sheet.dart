import 'package:cal_exp/model/expense_data.dart';
import 'package:flutter/material.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key, required this.onaddnewExpense});

  final void Function(ExpenseData expense) onaddnewExpense;

  @override
  State<AddBottomSheet> createState() {
    return _AddBottomSheetState();
  }
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Catagrories _selectedCatagory = Catagrories.food;

  void _getDatePicker() async {
    final present = DateTime.now();
    final firstDate =
        DateTime(present.year - 1, present.month, present.day - 7);
    final lastDate = DateTime(present.year, present.month, present.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: present,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenses() {
    final amountEntered = double.tryParse(
        _amountController.text); // Hello => null, 112.22 =>112.22
    final isamountInvalid = amountEntered == null || amountEntered <= 0;
    if (_titleController.text.trim().isEmpty ||
        isamountInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              'Please make sure that you have entered valid Title, Amount and a Date'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Okay"))
          ],
        ),
      );
      return;
    }
    widget.onaddnewExpense(ExpenseData(
        title: _titleController.text,
        amountspent: amountEntered,
        catagory: _selectedCatagory,
        date: _selectedDate!)
        );
        Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final keyboardOverplap = MediaQuery.of(context).viewInsets.bottom;// to overcome the overlay of kwyboard overlap in landscape mode and made content scrollabe
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16,16,16,keyboardOverplap+16),
          child: Column(
            children: [
              TextField(
                  controller: _titleController,
                  maxLength: 50,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  )),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefix: Text('Rs.'),
                          labelText: 'Amount')),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(_selectedDate == null
                          ? 'No Date Selected'
                          : formtter.format(_selectedDate!)),
                      IconButton(
                        onPressed: _getDatePicker,
                        icon: const Icon(Icons.calendar_month_outlined),
                      )
                    ],
                  ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCatagory,
                      items: Catagrories.values
                          .map(
                            (catagory) => DropdownMenuItem(
                              value: catagory,
                              child: Text(catagory.name.toUpperCase()),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null) {
                            return;
                          }
                          _selectedCatagory = value;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  ElevatedButton(
                      onPressed: _submitExpenses, child: const Text('Submit')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
