import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formtter = DateFormat.yMd();
const uuid = Uuid();

enum Catagrories { food, travel, entrtainment, shopping, others }

const catagoryIcons = {
  Catagrories.food: Icons.lunch_dining,
  Catagrories.travel: Icons.flight_takeoff,
  Catagrories.entrtainment: Icons.movie,
  Catagrories.shopping: Icons.shopping_cart,
  Catagrories.others: Icons.miscellaneous_services
};

class ExpenseData {
  ExpenseData(
      {required this.title,
      required this.amountspent,
      required this.catagory,
      required this.date})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amountspent;
  final DateTime date;
  final Catagrories catagory;

  String get formattedDateTime {
    return formtter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.catagory, required this.expenses});

  ExpenseBucket.forCatarogires(List<ExpenseData> allExpenses, this.catagory)
      : expenses = allExpenses
            .where((expense) => expense.catagory == catagory)
            .toList();

  final Catagrories catagory;
  final List<ExpenseData> expenses;

  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amountspent;
    }
    return sum;
  }
}
