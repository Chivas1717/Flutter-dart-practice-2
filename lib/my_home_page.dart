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
              child: Column(children: [
                const ShowingGreeting(),
                const SizedBox(
                  height: 180,
                ),
                const Text(
                  'You have liked empat this many times:',
                  style: TextStyle(color: Colors.green, fontSize: 20),
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _decrementCounter();
                        ScaffoldMessenger.of(context)
                            .showMaterialBanner(MaterialBanner(
                          content: const Text('Чому так?'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentMaterialBanner();
                                },
                                child: const Text('Закрити'))
                          ],
                          padding: const EdgeInsets.all(15),
                        ));
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Icon(Icons.thumb_down),
                    ),
                    ElevatedButton(
                      onPressed: _incrementCounter,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const Icon(Icons.thumb_up),
                    ),
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
