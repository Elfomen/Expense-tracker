import 'dart:io';

import 'package:expense_track/models/transaction.dart';
import 'package:expense_track/widgets/chart.dart';
import 'package:expense_track/widgets/new_transaction.dart';
import 'package:expense_track/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Quicksand',
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //     id: 't1', title: 'new shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: 'tt1', title: 'new t-shirt', amount: 25.99, date: DateTime.now()),
  ];
  

  bool _swichValue = true;

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(String title, String amount, date) {
    if (title.isEmpty || amount.isEmpty) {
      return;
    }
    if (date == null) {
      return;
    }
    double amt = double.parse(amount);

    if (amt <= 0) return;

    final newTx = Transaction(
        id: DateTime.now().toString(), title: title, amount: amt, date: date);
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void openAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(addNewTransaction: _addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    
    final transactionList = Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: TransactionList(
                  transactions: _transactions,
                  deleteTransaction: _deleteTransaction,
                ));
    
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expenses'),
        actions: [
          IconButton(
              onPressed: () => {openAddNewTransaction(context)},
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if(isLandScape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Show Chart'),
                Switch.adaptive(
                  value: _swichValue,
                  onChanged: (val) {
                    setState(() {
                      _swichValue = val;
                    });
                  },
                ),
              ],
            ),
            _swichValue ? Container(
              width: double.infinity,
              height: isLandScape ? MediaQuery.of(context).size.height * 0.8:MediaQuery.of(context).size.height * 0.3,
              child: Chart(transactions: _recentTransactions),
            ) : 
            transactionList ,

            if(!isLandScape) transactionList ,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container() :  FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => openAddNewTransaction(context),
      ),
    );
  }
}
