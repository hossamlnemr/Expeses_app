// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import, avoid_web_libraries_in_flutter
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, sort_child_properties_last

import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';
class NewExp extends StatefulWidget {
  const NewExp({
    Key? key,
    required this.onAddExpeense,
  }) : super(key: key);
 final void Function(Expense expense) onAddExpeense;

  @override
  State<NewExp> createState() => _NewExpState();
}

class _NewExpState extends State<NewExp> {
 final _titlecontroller= TextEditingController();
  final _amountcontroller= TextEditingController();
 DateTime? _selcdate;
Category _selcCategory=Category.travel;

  @override
  void dispose() {
    super.dispose();
    _titlecontroller.dispose();
    _amountcontroller.dispose();
 
  }
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
             TextField(
              controller: _titlecontroller,
              maxLength: 50,
              decoration: InputDecoration(label: Text('title'),),
             ) ,
              Row(
                children: [
                  Expanded(
                    child: TextField(
                    controller: _amountcontroller,
                    keyboardType: TextInputType.number,
                    
                    maxLength: 7,
                    decoration: InputDecoration(label: Text('amount'),prefixText: '\$'),
                   ),
                  ),
             SizedBox(width: 5,),
             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              Text(_selcdate==null? 'no date selected':DateFormat.yMd().format(_selcdate!))  ,
              IconButton(onPressed: ()async{
             final DateTime? pickdate=await showDatePicker(
              context: context, 
              initialDate: DateTime.now(),
             firstDate:DateTime.now(), 
             lastDate: DateTime(DateTime.now().year+2));
             setState(() {
               _selcdate=pickdate;
             });
              }, 
              icon: Icon(Icons.calendar_month))
              ],
             )
                ],
              ) ,
           SizedBox(height: 10.0,),
             Row(
              children: [
                DropdownButton(
                  value: _selcCategory,
                  items:Category.values.map((e) => DropdownMenuItem(
                  child: Text(e.name),
                   value: e
                   )).toList(),
               
                 onChanged: (val){
                  if(val==null){return;}
                  setState(() {
                    _selcCategory=val;
                  });
                 }
                 ),
                 Spacer(),
      
                TextButton(onPressed: ()=>Navigator.pop(context), child: Text('cancel')),
                ElevatedButton(
                  onPressed: (){
                final enteredAmount=double.tryParse(_amountcontroller.text);
                final bool invalidAmount=enteredAmount==null ||enteredAmount <0;
              //const snackBar=   SnackBar(content: Text('error'));
                if(_titlecontroller.text.trim().isEmpty||invalidAmount||_selcdate==null){
                 
              //ScaffoldMessenger.of(context).showSnackBar(snackBar);
              
              showDialog(context: context, builder: (ctx)=>AlertDialog(
                title: Text('Invaild inputs'),
                content:Text('please enter correct data'),
                actions: [
                  TextButton(onPressed: ()=>Navigator.pop(ctx), child: Text('ok'))
                ],
      
              ));
                }
                else{
                  widget.onAddExpeense(Expense(category: _selcCategory, title: _titlecontroller.text, amount: enteredAmount, date:_selcdate!));
                  Navigator.pop(context);
                }
                
                  }, 
                
                child: Text('Save Expense')),
              ],
             ),
      
            ],
          ),
        ),
      ),
    );
  }
}