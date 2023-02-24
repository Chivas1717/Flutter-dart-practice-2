import 'package:flutter/material.dart';

class ShowingGreeting extends StatefulWidget {
  const ShowingGreeting({super.key});

  @override
  State<ShowingGreeting> createState() => _ShowingGreetingState();
}

class _ShowingGreetingState extends State<ShowingGreeting> {
  final Student student = Student('Mark', 'Hudzovskyi', DateTime(2004, 17, 10));
  void _changeStatus() {
    if (student.status == true) {
      setState(() {
        student.status = false;
      });
    } else {
      setState(() {
        student.status = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 100),
        Text(
            '${student.fullName} is ${student.status ? 'subscribed' : 'not subscribed'}'),
        ElevatedButton.icon(
          onPressed: _changeStatus,
          style: ElevatedButton.styleFrom(
              backgroundColor: student.status ? Colors.red : Colors.green),
          icon: Icon(student.status ? Icons.cancel_outlined : Icons.done),
          label: Text(student.status ? 'Cancel' : 'Subscribe'),
        ),
      ],
    ));
  }
}

class Student {
  final String firstName, secondName;
  final DateTime birthDate;
  late bool _status;

  Student(this.firstName, this.secondName, this.birthDate,
      [this._status = false]);

  String get fullName => '$firstName $secondName';
  bool get status => _status;
  // String get status => _status;

  set status(bool s) {
    _status = s;
  }

  // set firstName(String firstName) {
  //   _firstName = firstName;
  // }

  // set secondName(String firstName) {
  //   _firstName = firstName;
  // }
}
