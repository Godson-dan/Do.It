import 'package:flutter/foundation.dart';

class TaskProvider extends ChangeNotifier {
  List<String> todos = [];
  //List<Task> get tasks => _tasks;

  void addTask(String task) {
    todos.add(task);
    notifyListeners();
  }

  void removeTask(String task) {
    todos.remove(task);
    notifyListeners();
  }
}
