import 'package:demo_003/widgets/bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transcation.dart';

class Chart extends StatelessWidget {
  final List<Transcation> recentTranscation;
  Chart(this.recentTranscation);

  List<Map<String, Object>> get groupedTranscation {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double amount = 0;
      for (var i = 0; i < recentTranscation.length; i++) {
        if (recentTranscation[i].date.year == weekDay.year &&
            recentTranscation[i].date.month == weekDay.month &&
            recentTranscation[i].date.day == weekDay.day) {
          amount += recentTranscation[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': amount
      };
    });
  }

  double get percentage {
    return groupedTranscation.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTranscation.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                percentage == 0.0
                    ? 0.0
                    : (data['amount'] as double) / percentage,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
