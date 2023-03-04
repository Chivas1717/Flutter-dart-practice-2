class Person {
  final String firstName, secondName;
  
  Person(this.firstName, this.secondName);
  
  factory Person.student(String fn, String sn) {
    return Student(firstName: fn, secondName: sn, );
  }
  
  String get fullName => '$firstName $secondName';
  
  dynamic get todo => {};
  void makeToDoListDaily(bool temp) {}
}

class Student extends Person {
  late bool _status = true;
  ToDoList? todoList;
  
  Student({required String firstName, required String secondName}): super(firstName, secondName);

  bool get status => _status;
  @override
  ToDoList? get todo => todoList;

  set status(bool s) {
    _status = s;
  }
  @override
  void makeToDoListDaily(bool isDaily) {
    if(isDaily) {
      todoList = ToDoList('Monday', {});
    } else {
      todoList = ToDoList.noDay({});
    }
  }
}

class ToDoList {
  String? day;
  Map items;
  Function tasksTotalCount;
  ToDoList([this.day = '', this.items = const {}]): tasksTotalCount = createCounter();
  ToDoList.noDay([this.items = const {}]): tasksTotalCount = createCounter();
  
  get todos => items;
  get totalCount => tasksTotalCount(0);
  
  void addTodo(title, todo) {
    items[title] = items.containsKey(title) ? [...(items[title]), todo] : [todo];
    tasksTotalCount(todo.split(', ').length);
  }
  
  void showToDoList() {
    if (items.isEmpty) {
      print('ToDo list is empty');
      return;
    }
    
    print('${day ?? 'This'} list has $totalCount tasks to do:\n');
    todos.forEach((k, list) => {
      print('Category: $k'),
      print('Tasks: ${list.join(', ')} \n'),
    });
  }
}

// class ToDoList2 {
//   Map items;
  
//   ToDoList2([this.items = const {}]);
  
//   factory ToDoList2.makelist({required bool isDaily, String day = '', itemssss = const {}}) {
//     if (isDaily) {
//       return DailyToDoList(day, itemssss);
//     } else {
//       return RegularToDoList(itemssss);
//     }
//   }
  
//   get todos => items;
  
//   void addTodo(title, todo) {
//     items[title] = items.containsKey(title) ? [...(items[title]), todo] : [todo];
//   }
  
//   void showToDoList() {
//   }
  
// }

// class DailyToDoList extends ToDoList2 {
//   late String day = '';
  
//   DailyToDoList(String day, [items = const {}]);
//   @override
//   void showToDoList() {
//     print('$day list has  tasks to do:\n');
//     if (items.isEmpty) {
//       print('ToDo list is empty');
//     }
//     todos.forEach((k, list) => {
//       print('Category: $k'),
//       print('Tasks: ${list.join(', ')} \n'),
//     });
//   }
// }

// class RegularToDoList extends ToDoList2 {
//   RegularToDoList([items = const {}]);
//   @override
//   void showToDoList() {
//     print(' list has  tasks to do:\n');
//     if (items.isEmpty) {
//       print('ToDo list is empty');
//     }
//     todos.forEach((k, list) => {
//       print('Category: $k'),
//       print('Tasks: ${list.join(', ')} \n'),
//     });
//   }
// }
//замикання
Function createCounter() {
  num count = 0;
  num returnFunc(num i) {
    count += i;
    return count;
  }
  return returnFunc;
}

void main() {
  
//   final mondayTodos = ToDoList('Monday', {});
//   final noDayTest = ToDoList.noDay({});
//   mondayTodos.addTodo('homework', 'English');
//   mondayTodos.addTodo('exercise', 'Push ups, Pull ups');
//   mondayTodos.addTodo('homework', 'Math');
  
//   noDayTest.addTodo('walk', 'go to park with friends');
//   print(mondayTodos.todos);
//   mondayTodos.showToDoList();
  
  final student1 = Person.student('James', 'Bond');
  final student2 = Person.student('Jason', 'Born');
  student1.makeToDoListDaily(true);
  student2.makeToDoListDaily(false);
  
  student1.todo.addTodo('homework', 'English');
  student2.todo.addTodo('homework2', 'English2');
  student1.todo.showToDoList();
  student2.todo.showToDoList();
  print(student1.fullName);
}
