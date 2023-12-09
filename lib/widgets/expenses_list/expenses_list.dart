

import 'package:expenses_app/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

import '../../models/expense.dart';

class Expenseslist extends StatelessWidget {
  const Expenseslist({
    super.key,
    required this.expenses, required this.onremExpeense,
    
  }) ;

  final List<Expense> expenses;
   final void Function(Expense expense) onremExpeense;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context,index) =>Dismissible(
        background: Container(
        decoration: BoxDecoration(
          color:Theme.of(context).colorScheme.error.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
          
          ),
        margin: Theme.of(context).cardTheme.margin,child:const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Icon(Icons.delete,size:50,),
          ],
        ),
        ),
        
        key: ValueKey(expenses[index]),
       child: ExpensesItem(expense: expenses[index]),
       onDismissed:(direction) => onremExpeense(expenses[index]),
       ),
      
      );
  }
}