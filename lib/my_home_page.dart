import 'package:flutter/material.dart';
import 'package:flutter_application_test/greeting.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter != 0) {
      setState(() {
        --_counter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.wheelchair_pickup),
        title: Text(widget.title),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Opacity(
              opacity: 0.8,
              child: Image.asset('assets/imgs/bg.png', fit: BoxFit.cover),
            )),
            Center(
              child: Column(children: const [
                SizedBox(height: 40),
                ShowingStatus(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
