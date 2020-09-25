import 'package:flutter/material.dart';

import 'widgets/chart.dart';
import 'widgets/new_transcation.dart';
import 'widgets/transcation_list.dart';

import 'models/transcation.dart';

void main() => runApp(DemoApp003());

class DemoApp003 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
        errorColor: Colors.purple,
        fontFamily: 'Poppins1',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Poppins1',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                button: TextStyle(
                  color: Colors.white,
                ),
              ),
        ),
      ),
      home: _DemoApp003State(),
    );
  }
}

class _DemoApp003State extends StatefulWidget {
// value changes function var
  // String titleInput;
  // String amountInput;

  @override
  __DemoApp003StateState createState() => __DemoApp003StateState();
}

class __DemoApp003StateState extends State<_DemoApp003State> {
  final List<Transcation> _userTranscation = [];
  List<Transcation> get lastSevenDays {
    return _userTranscation.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTranscation(String txTitle, double txAmount, DateTime date) {
    final txAdd = Transcation(
      title: txTitle,
      amount: txAmount,
      date: date,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTranscation.add(txAdd);
    });
  }

  void showTranscationList(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTranscation(_addTranscation),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTranscation(String id) {
    setState(() {
      _userTranscation.retainWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finance Manager'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () => showTranscationList(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(lastSevenDays),
            TranscationList(_userTranscation, _deleteTranscation),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showTranscationList(context),
      ),
    );
  }
}
