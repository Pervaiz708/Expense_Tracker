import 'package:cal_exp/Widgets/expense_list/expense_items.dart';
import 'package:cal_exp/model/expense_data.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key, 
    required this.expenses,
    required this.onRemoveExpense
    });
  final List<ExpenseData> expenses;
  final void Function(ExpenseData expense) onRemoveExpense;

  @override
  Widget build(context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index)=>
          Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error,
              margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
            ),
              onDismissed: (direction){
                onRemoveExpense(
                  expenses[index]);// this will remove the expenses according to index
              },
            child: ExpenseItems(
              expenses[index]
              ),
              )
        );
  }
}
