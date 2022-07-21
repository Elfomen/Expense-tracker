import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({Key? key, required this.addNewTransaction}) : super(key: key);

  final Function addNewTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  var _selectedDate ;

  void _presentDatePicker(){
    showDatePicker(context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2019), 
    lastDate: DateTime.now()).then((date) {
      if(date == null) return ;
      setState(() {
        _selectedDate = date;  
      });
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top:10 , left: 10 ,right: 10 , 
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleController,
                // onSubmitted: widget.addNewTransaction(titleController.text , amountController.text),
                // onChanged: handleTitleChange ,
                decoration: const InputDecoration(
                  labelText: 'Enter the Title here',
                ),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                // onSubmitted: widget.addNewTransaction(titleController.text , amountController.text) ,
                //  onChanged: handleAmountChange,
                decoration: const InputDecoration(labelText: 'Amount'),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(child: Text(_selectedDate==null ?  'No date choosen' : DateFormat.yMMMd().format(_selectedDate))),
                    FlatButton(
                      onPressed: _presentDatePicker, 
                      child: Text('choose date' , 
                      style: TextStyle(
                        fontWeight: FontWeight.bold , 
                        color: Theme.of(context).primaryColor
                      ),))
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () => {
                        widget.addNewTransaction(
                            titleController.text, amountController.text , _selectedDate),
                        Navigator.of(context).pop()
                      },
                  child: const Text('Add transaction'))
            ],
          ),
        ),
      ),
    );
  }
}
