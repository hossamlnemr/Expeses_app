// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expenses_app/models/expense.dart';
// ignore: unused_import
import 'package:expenses_app/widgets/chart/chart.dart';
import 'package:expenses_app/widgets/new_exp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dark_mode_prov.dart';
import 'expenses_list/expenses_list.dart';



class Expenses extends StatefulWidget {
  const Expenses({super.key });



  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
     
  final List<Expense> _registeredExpenses=[

    Expense(category: Category.work, title: 'flutter work', amount: 69.9, date: DateTime.now()),
    Expense(category: Category.leisure, title: 'cinema', amount: 29.9, date: DateTime.now()),
    Expense(category: Category.food, title: 'breakfast', amount: 18.9, date: DateTime.now()),
    Expense(category: Category.travel, title: 'egypt air', amount: 50.9, date: DateTime.now()),

  ];

  void addExpense(Expense expense){
setState(() {
  _registeredExpenses.add(expense);
});
  }
   void remExpense(Expense expense){
setState(() {
  _registeredExpenses.remove(expense);
});
  }

  
  @override
  Widget build(BuildContext context) {
    var m=MediaQuery.of(context);

    Widget maincontent=const Center(child: Text('No Expenses',style: TextStyle(fontSize: 30),),);
    if(_registeredExpenses.isNotEmpty){
      maincontent=Expenseslist(expenses: _registeredExpenses, onremExpeense: remExpense);
    }
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Expenses Tracker",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
      actions: [ 
        IconButton(onPressed: (){
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        }, 
      icon:Icon(Icons.dark_mode)),
      ],
      //backgroundColor: Color.fromARGB(255, 179, 174, 175),
      ),
      body: Center(
        child:m.size.width<600? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Chart(expenses:_registeredExpenses)),
            Expanded(
            child: maincontent,
           ),
           
          ],
        ):Row(
          children: [
            Expanded(child: Chart(expenses:_registeredExpenses)),
            Expanded(
            child: maincontent,
           ),
           
          ],
        ) ,
        
        
       
        ),
       floatingActionButton: FloatingActionButton(onPressed: (){
       showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context, builder: (ctx)=>NewExp(onAddExpeense: addExpense));
      }, 
      
      child:Icon(Icons.add)),)
    ;
  }
}

