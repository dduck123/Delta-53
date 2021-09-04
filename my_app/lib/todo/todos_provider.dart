import 'package:flutter/cupertino.dart';
import 'package:my_app/todo/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: 'Project Proposal 🐕',
      description: '''- Generate ideas
- Brainstorm
- Gather feedback from teammates
- Come up with a plan and tasks will be designated accordingly''', id: '',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Plan a course to improve employees\' skills',
      description: '''- Find a skill which is suitable for the company
- Garner feedback from employees
- Find a suitable method to conduct these courses''', id: '',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Grab lunch with Miller 😋', id: '',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Plan wife\'s birthday party 🎉🥳', id: '',
    ),
  ];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void addTodo(Todo todo) {
    _todos.add(todo);

    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);

    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    notifyListeners();
  }
}
