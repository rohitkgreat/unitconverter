import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'package:unitconvert/models/historyitem.dart';

import 'historypage.dart';

class ConvertPage extends StatefulWidget {
  @override
  _ConvertPageState createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {
  final TextStyle inputStyle = TextStyle(
    fontSize: 18,
    color: Colors.black87,
  );

  final TextStyle labelStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );
  String? _startMeasure;
  String? _convertedMeasure;
  double? _numberForm;
  String? _resultMessage;

  void initState() {
    _numberForm = 0;
    super.initState();
  }

  final List<String> _measures = [
    'Inches',
    'Feet',
    'Centimeters',
  ];
  final Map<String, int> _measuresMap = {
    'Inches': 0,
    'Feet': 1,
    'Centimeters': 2,
  };

  dynamic _formulas = {
    '0': [1, 0.0833, 2.54],
    '1': [12, 1, 30.48],
    '2': [0.393, 0.032, 1],
  };
  var ans;
  void convert(double value, String from, String to) {
    int? nFrom = _measuresMap[from];
    int? nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;

    ans = double.parse(result.toString()).toStringAsFixed(2);
    // print(ans);
    _resultMessage = ' ${result.toString()}';

    setState(() {
      _resultMessage = ans;
    });
  }

  void add(String first, String second, String third, String zero) {
    final historys = History()
      ..zero = zero
      ..first = first
      ..second = second
      ..ans = third;

    Hive.box<History>('history').add(historys);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Historypage()));
              },
              icon: Icon(Icons.history))
        ],
        title: Text('Length Converter'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Spacer(),
            TextField(
              style: inputStyle,
              decoration: InputDecoration(
                hintText: "Please enter the value",
              ),
              onChanged: (text) {
                var rv = double.tryParse(text);
                if (rv != null) {
                  setState(() {
                    _numberForm = rv;
                  });
                }
              },
            ),
            Spacer(),
            //Text((_numberForm==null)? '' : _numberForm.toString())
            Row(
              children: [
                DropdownButton(
                  style: inputStyle,
                  hint: Text(
                    "Unit",
                    style: inputStyle,
                  ),
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _startMeasure = value.toString();
                    });
                  },
                  value: _startMeasure,
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.blue[600],
                  size: 24.0,
                ),
                Spacer(),
                DropdownButton(
                  hint: Text(
                    "Unit",
                    style: inputStyle,
                  ),
                  style: inputStyle,
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: inputStyle,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _convertedMeasure = value.toString();
                    });
                  },
                  value: _convertedMeasure,
                ),
              ],
            ),

            Spacer(
              flex: 1,
            ),
            ElevatedButton(
              // color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Convert',
                    style: TextStyle(color: Colors.white, fontSize: 25)),
              ),
              onPressed: () {
                if (_startMeasure!.isEmpty ||
                    _convertedMeasure!.isEmpty ||
                    _numberForm == 0) {
                  return;
                } else {
                  convert(_numberForm!, _startMeasure!, _convertedMeasure!);
                  add(
                    _startMeasure!,
                    _convertedMeasure!,
                    _resultMessage.toString(),
                    _numberForm.toString(),
                  );
                }
              },
            ),

            Spacer(
              flex: 1,
            ),
            Container(
              height: 80,
              width: 550,
              decoration: BoxDecoration(
                  color: Color(0xff2A0944),
                  // border: Border.all(color: Colors.black, width: 5),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                (_resultMessage == null) ? '0' : '$_resultMessage',
                style: TextStyle(color: Colors.white, fontSize: 60),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(
              flex: 8,
            ),
          ],
        ),
      ),
    );
  }
}
