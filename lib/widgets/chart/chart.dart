// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});
final  List <Expense> expenses;
List<ExpenseBucket> get buckets{
  return[
    ExpenseBucket.forcategory(expenses, Category.food),
   ExpenseBucket.forcategory(expenses, Category.travel),
    ExpenseBucket.forcategory(expenses, Category.leisure),
    ExpenseBucket.forcategory(expenses, Category.work)

  ];
}
get maxTotalExpense{
  double maxTotalExpense=0;
  for (var element in buckets) {
    if(element.totalExpenses >maxTotalExpense){
      maxTotalExpense=element.totalExpenses;
    }
  }

  return maxTotalExpense;
}



  @override
  Widget build(BuildContext context) {
    final bool isDarkMode=MediaQuery.of(context).platformBrightness==Brightness.dark;

    return  LayoutBuilder(
      builder:(ctx, constraints) => 
     Container(
        margin:const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
        width: double.infinity,
        height: constraints.maxHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: LinearGradient(colors: 
             [
             Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
             ],
             begin: Alignment.bottomCenter,
             end: Alignment.topCenter,
          ),
        ),
    
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
    
                  for(final ele in buckets)  ChartBar(
                    fill: ele.totalExpenses==0?0:ele.totalExpenses/maxTotalExpense,) ,
                
                ],
              ),
            ),
              constraints.minHeight<150?Container():
            const SizedBox(height: 12,),
            // constraints.minHeight<150?Container():
             Row(
               children:buckets.map((e) => Expanded(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal:4.0),
                   child: Icon(Categoryicons[e.category],color:
                   isDarkMode? Theme.of(context).colorScheme.primary:
                   Theme.of(context).colorScheme.primary.withOpacity(0.7),
                   ),
                 ),
               )).toList(),
             ),
          ],
        ),
      ),
    );
  }
}