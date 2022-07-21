import 'package:expense_track/models/transaction.dart';
import 'package:expense_track/widgets/chart_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.transactions}) : super(key: key);

  final List<Transaction> transactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year) {
          totalSum += transactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay).substring(0 , 1), 'amount': totalSum};
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return (sum + (item["amount"] as double));
    } 

    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: 
            groupedTransactionValues.map((tr) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(label: tr["day"].toString(), spendingAmount: (tr["amount"] as double), spendingPerOfTotal: (tr["amount"] as double) / maxSpending));
            }).toList()
          ,
        ),
      ),
    );
  }
}
