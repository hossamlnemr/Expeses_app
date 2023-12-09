// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:expenses_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key,required this.expense});
final Expense expense;
  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title,style: Theme.of(context).textTheme.titleLarge,),
            const SizedBox(height: 4,),
            Row(
              
              children: [
            Text('\$${expense.amount.toStringAsFixed(2)}'),
            Spacer(),
            Row(
              children: [
                 Icon(Categoryicons[expense.category]),
               const SizedBox(width: 4,),
            Text(expense.formattefdate),

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