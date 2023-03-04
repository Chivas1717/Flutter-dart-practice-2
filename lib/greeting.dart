import 'package:flutter/material.dart';

class ShowingStatus extends StatefulWidget {
  const ShowingStatus({super.key});

  @override
  State<ShowingStatus> createState() => _ShowingStatusState();
}

class _ShowingStatusState extends State<ShowingStatus> {
  var student = Person.student('Mark', 'Hudzovskyi') as Student;

  void _createToDo() {
    if (student.todo == null) {
      setState(() {
        student.makeToDoListDaily(true);
        student.todo!.addTodo('homework', 'English');
        student.todo!.addTodo('exercise', 'push ups');
        student.todo!.addTodo('homework', 'Math');
        student.todo!.addTodo('homework', 'French');
        student.todo!.addTodo('exercise', 'pull ups');
        student.todo!.addTodo('Work', 'finish report');
        student.todo!.addTodo('Work', 'call my boos');
        student.todo!.removeTodo('homework', 'French');
        // student.todo!.addTodo('homework', '${student.todo.runtimeType}');
      });
    }
  }

  void _deleteToDo() {
    if (student.todo != null) {
      setState(() {
        student.deleteToDoList();
      });
    }
  }

  void _changeStatus() {
    assert(student.status is bool);
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
        Text('${student.fullName} ${student.playVideoGame()}'),
        const SizedBox(
          height: 120,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: _createToDo,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              icon: const Icon(Icons.add),
              label: const Text('Create'),
            ),
            ElevatedButton.icon(
              onPressed: _deleteToDo,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              icon: const Icon(Icons.cancel_outlined),
              label: const Text('Delete'),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('TODO LIST'),
        const SizedBox(
          height: 15,
        ),
        Text(student.todo?.day ?? "TODO LIST IS EMPTY"),
        if (student.todo != null)
          Text('List has ${student.todo!.totalCount} tasks to do'),
        const SizedBox(
          height: 120,
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
}

class Gamer {
  String topGame = 'CS-GO';
  String playVideoGame() {
    return 'is playing $topGame';
  }
}

class Student extends Person with Gamer {
  late bool _status = true;
  ToDoList? todoList;

  Student({required String firstName, required String secondName})
      : super(firstName, secondName);

  bool get status => _status;
  ToDoList? get todo => todoList;

  set status(bool s) {
    _status = s;
  }

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

  void removeTodo(title, todo) {
    items[title].remove(todo);
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
              Text(
                'Category: ${keys[index]}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(todos[keys[index]].join('\n')),
              const SizedBox(
                height: 30,
              ),
            ],
          );
        },
      ),
    );
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
