import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTranscation extends StatefulWidget {
  final Function addTranscation;
  NewTranscation(this.addTranscation);

  @override
  _NewTranscationState createState() => _NewTranscationState();
}

class _NewTranscationState extends State<NewTranscation> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selecetdDate;
  void newTx() {
    if (_titleController.text.isEmpty ||
        double.parse(_amountController.text) <= 0) {
      return;
    }

    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    widget.addTranscation(title, amount, _selecetdDate);

    Navigator.of(context).pop();
  }

  void _openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((onValue) {
      if (onValue == null) {
        return;
      }
      setState(() {
        _selecetdDate = onValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => newTx(),
              // onChanged: (e) => titleInput = e,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => newTx(),
              // onChanged: (e) => amountInput = e,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selecetdDate == null
                          ? 'No date choosen!'
                          : 'Picked date:${DateFormat.yMMMEd().format(_selecetdDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Choose date'),
                    onPressed: _openDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transcation'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: newTx,
            ),
          ],
        ),
      ),
    );
  }
}
