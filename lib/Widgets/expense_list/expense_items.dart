import 'package:cal_exp/model/expense_data.dart';
import 'package:flutter/material.dart';

class ExpenseItems extends StatelessWidget {
  const ExpenseItems(this.expense,{super.key});

  final ExpenseData expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title, style: Theme.of(context).textTheme.titleLarge
            ),
            const SizedBox(height: 4,),
            Row(
              children: [
                 Text('Rs.${expense.amountspent.toString()}'),
                 const Spacer(),
                 Row(
                   children: [
                     Icon(catagoryIcons[expense.catagory]),
                     const SizedBox(width: 8,),
                     Text(expense.formattedDateTime),
                   ],
                 )

              ],
            )
          ],
        ),
      ),
    );
  }
}