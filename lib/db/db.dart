import 'package:hive_flutter/hive_flutter.dart';

class ToDoDB {
  List toDoList = [];
  final _myBox = Hive.box('ToDoDb');

  void createInitialData() {
    toDoList = [
      ['Test ToDO', false]
    ];
  }

  void readData() {
    toDoList = _myBox.get('TODOLIST');
  }

  void updateData() {
    _myBox.put('TODOLIST', toDoList);
  }
}
