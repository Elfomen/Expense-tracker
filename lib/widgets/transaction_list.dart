import 'package:expense_track/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key, required this.transactions, required this.deleteTransaction})
      : super(key: key);

  final List<Transaction> transactions;

  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 500,
      height: MediaQuery.of(context).size.height * 0.7,
      child: transactions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('No transaction added yet'),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8 , horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        DateFormat.yMMMMd().format(transactions[index].date) , 
                      ),
                    trailing: IconButton(
                      onPressed: (){
                        deleteTransaction(transactions[index].id);
                      },
                      icon: const Icon(Icons.delete , color: Colors.red,),
                    ),
                  ),
                );
              },
            ),
    );
  }
}


// Card(
//                     child: Row(
//                   children: [
//                     Container(
//                       margin:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                       child: Text(
//                         '\$ ${transactions[index].amount.toString()}',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                             color: Theme.of(context).primaryColor),
//                       ),
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                               color: Theme.of(context).primaryColor, width: 2)),
//                       padding: EdgeInsets.all(10),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           transactions[index].title,
//                           style: const TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           DateFormat.yMMMMd().format(transactions[index].date),
//                           style: const TextStyle(color: Colors.grey),
//                         )
//                       ],
//                     )
//                   ],
//                 )
//               );