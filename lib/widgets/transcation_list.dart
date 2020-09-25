import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transcation.dart';

class TranscationList extends StatelessWidget {
  final List<Transcation> _userTranscation;
  final Function deleteTx;
  TranscationList(this._userTranscation, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _userTranscation.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transaction added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/1.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 33,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text('\$${_userTranscation[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      _userTranscation[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(_userTranscation[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () {
                        deleteTx(_userTranscation[index].id);
                      },
                    ),
                  ),
                );
              },
              itemCount: _userTranscation.length,
            ),
    );
  }
}
