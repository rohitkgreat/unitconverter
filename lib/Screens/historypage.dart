import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:unitconvert/models/historyitem.dart';

import '../import.dart';

class Historypage extends StatelessWidget {
  Historypage({Key? key}) : super(key: key);
  final List<History> result = Hive.box<History>('history')
      .values
      .toList()
      .reversed
      .toList()
      .cast<History>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        'History',
        Icons.auto_delete_outlined,
        () {
          Navigator.pop(context);
          Hive.box<History>('history').clear();
          showToast(context, 'History cleared successfully');
        },
      ),
      body: result.isEmpty
          ? Center(
              child: Text(
                'Empty!',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(fontSize: 12.0),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(10.0),
              itemCount: result.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  tileColor: Colors.grey,
                  title: Text('${result[i].first} ${result[i].zero}'),
                  subtitle: Text('${result[i].second} ${result[i].ans}'),
                );
              },
            ),
    );
  }
}
