import 'package:cal_exp/Widgets/charts/chart_bar.dart';
import 'package:cal_exp/model/expense_data.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expense});

  final List<ExpenseData> expense;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCatarogires(expense, Catagrories.food),
      ExpenseBucket.forCatarogires(expense, Catagrories.travel),
      ExpenseBucket.forCatarogires(expense, Catagrories.entrtainment),
      ExpenseBucket.forCatarogires(expense, Catagrories.shopping),
      ExpenseBucket.forCatarogires(expense, Catagrories.others),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;
    for (final bucket in buckets) {
      if (bucket.totalExpense > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpense;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.3),
              Theme.of(context).colorScheme.primary.withOpacity(0.0)
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  ChartBar(
                    fill: bucket.totalExpense == 0
                        ? 0
                        : bucket.totalExpense / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: buckets.map((bucket) => Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(catagoryIcons[bucket.catagory]),
                ))).toList(),
          )
        ],
      ),
    );
  }
}
