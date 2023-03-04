import 'package:flutter/material.dart';

class ShowingStatus extends StatefulWidget {
  const ShowingStatus({super.key});

  @override
  State<ShowingStatus> createState() => _ShowingStatusState();
}

class _ShowingStatusState extends State<ShowingStatus> {
  // final Student student =
  //     Student('Markjiggbgibjhn', 'Hudzovskyi', DateTime(2004, 17, 10));
  var student = Person.student('James', 'Bond') as Student;
  // student.makeToDoListDaily(true);

  void createToDo() {
    if (student.todo == null) {
      student.makeToDoListDaily(true);
      student.todo!.addTodo('homework', 'English');
      student.todo!.addTodo('exercise', 'push ups');
      student.todo!.addTodo('homework', 'Math');
    }
  }

  void _changeStatus() {
    if (student.status == true) {
      setState(() {
        student.status = false;
        student.deleteToDoList();
      });
    } else {
      setState(() {
        student.status = true;
        createToDo();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
        ),
        const Text('TODO LIST'),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(student.todo?.day ?? "TODO LIST IS EMPTY"),
            if (student.todo != null) const Text('data')
          ],
        ),
        if (student.todo != null) student.todo!.showToDoList()
      ],
    ));
  }
}

class Person {
  final String firstName, secondName;

  Person(this.firstName, this.secondName);

  factory Person.student(String fn, String sn) {
    return Student(
      firstName: fn,
      secondName: sn,
    );
  }

  String get fullName => '$firstName $secondName';

  // dynamic get todo => {};
  // void makeToDoListDaily(bool temp) {}
}

class Student extends Person {
  late bool _status = true;
  ToDoList? todoList;

  Student({required String firstName, required String secondName})
      : super(firstName, secondName);

  bool get status => _status;
  // @override
  ToDoList? get todo => todoList;

  set status(bool s) {
    _status = s;
  }

  // @override
  void makeToDoListDaily(bool isDaily) {
    if (isDaily) {
      todoList = ToDoList('Monday', {});
    } else {
      todoList = ToDoList.noDay({});
    }
  }

  void deleteToDoList() {
    todoList = null;
  }
}

class ToDoList {
  String? day;
  Map items;
  Function tasksTotalCount;
  ToDoList([this.day = '', this.items = const {}])
      : tasksTotalCount = createCounter();
  ToDoList.noDay([this.items = const {}]) : tasksTotalCount = createCounter();

  get todos => items;
  get totalCount => tasksTotalCount(0);

  void addTodo(title, todo) {
    items[title] = items.containsKey(title) ? [...items[title], todo] : [todo];
    tasksTotalCount(todo.split(', ').length);
  }

  Container showToDoList() {
    var keys = todos.keys.toList();
    return Container(
      height: 150,
      child: ListView.builder(
        itemCount: keys.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Text(keys[index]),
              Text(todos[keys[index]].join('\n')),
            ],
          );
        },
      ),
    );

    // return Column(
    //   children: [
    //     Text('${day ?? 'This'} list has $totalCount tasks to do'),
    //     todos.map((k, list) => Column(
    //           children: [
    //             Text('Category: $k'),
    //             Text('Tasks: ${list.join(', ')} \n')
    //           ],
    //         )),
    //   ],
    // );
  }
}

//замикання
Function createCounter() {
  num count = 0;
  num returnFunc(num i) {
    count += i;
    return count;
  }

  return returnFunc;
}
