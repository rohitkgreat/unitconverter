import 'package:flutter/material.dart';

import 'package:unitconvert/Screens/length.dart';
import 'package:unitconvert/Screens/temp.dart';

import 'historypage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff261C2C),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Historypage()));
              },
              icon: Icon(Icons.history))
        ],
        title: Text('Unit Converter'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ConvertPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Lengths',
                    style: TextStyle(fontSize: 34),
                  ),
                )),
            SizedBox(
              height: 50,
            ),
            OutlinedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(2),
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Temp()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Temperature ',
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
