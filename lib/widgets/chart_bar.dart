import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({Key? key, required this.label, required this.spendingAmount, required this.spendingPerOfTotal}) : super(key: key);

  final String label;
  final double spendingAmount;
  final double spendingPerOfTotal;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder:  (context, constraints) {
      return Column(
      children: [
        Container(
          height: constraints.maxHeight * 0.15,
          child: FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}'))) ,
        SizedBox(height: constraints.maxHeight * 0.05,) ,
        Container(
          height:constraints.maxHeight * 0.6 , 
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,  width: 1.0) ,
                  color: Color.fromRGBO(220,220,220,1) ,
                  borderRadius: BorderRadius.circular(10)                ),
              ) ,
              FractionallySizedBox(
                heightFactor: (spendingPerOfTotal >=0 ?spendingPerOfTotal : 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor ,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              )
            ],
          ),
        ) ,
        SizedBox(height: constraints.maxHeight * 0.1,) ,
        Container(
          height: constraints.maxHeight * 0.1 ,
          child: FittedBox(child: Text(label)))
      ],
    );
    });
  }
}