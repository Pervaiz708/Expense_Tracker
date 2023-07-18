import 'package:cal_exp/Widgets/add_bottom_sheet.dart';
import 'package:cal_exp/Widgets/charts/chart.dart';
import 'package:cal_exp/Widgets/expense_list/expense_list.dart';
import 'package:cal_exp/main.dart';
import 'package:cal_exp/model/expense_data.dart';
import 'package:flutter/material.dart';
// import 'package:toggle_switch/toggle_switch.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final List<ExpenseData> _registeredExpenses = [
    ExpenseData(
      title: 'Movie',
      amountspent: 1100,
      catagory: Catagrories.entrtainment,
      date: DateTime.now(),
    ),
    ExpenseData(
        title: 'Vacations in Gilgit',
        amountspent: 24500,
        catagory: Catagrories.travel,
        date: DateTime.now())
  ];

  void _addBottomSheet() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true, // this will make bottom sheet full screened
        context: context,
        builder: (ctx) => AddBottomSheet(
              onaddnewExpense: _addExpense,
            ));
  }

  void _addExpense(ExpenseData expense) {
    setState(() => _registeredExpenses.add(expense));
  }

  void _onRemoveExpense(ExpenseData expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        content: Text("Removed ${expense.title} from your list."),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            })));
  }

  void onToggleSwitch(var index){
    var currentIndex = index;
                setState(() {
                  if(currentIndex==0){
                    ThemeData.light().copyWith(
                      brightness: Brightness.light,
                      colorScheme: kColorScheme
                    );
                  }
                  else{
                    ThemeData.dark().copyWith(
                      brightness: Brightness.dark,
                      colorScheme: kdarkColorScheme
                    );
                  }
                });
  }

  @override
  Widget build(context) {
    final width = MediaQuery.of(context).size.width;
    Widget maincontent = const Center(
      child: Text('No Expense Found. Start Adding Some.'),
    );
    if (_registeredExpenses.isNotEmpty) {
      maincontent = ExpenseList(
        expenses: _registeredExpenses,
        onRemoveExpense: _onRemoveExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expenses Tracker",
          textAlign: TextAlign.end,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: _addBottomSheet,
          )
        ],
      ),
      body: width < 600? Column(
        children: [
          Chart(expense: _registeredExpenses),
          Expanded(child: maincontent),
        ],
      )
      : Row(
        children: [
          Expanded(child: Chart(expense: _registeredExpenses)),
          Expanded(child: maincontent),
        ],
      )
    );
  }
}
