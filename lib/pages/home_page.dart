import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/db/db.dart';
import 'package:todo_list/pages/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('ToDoDb');
  ToDoDB db = ToDoDB();

  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else
      (db.readData());
    super.initState();
  }

  void checkBoxState(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void addToDOItem(String task) {
    setState(() {
      db.toDoList.add([task, false]);
    });
    db.updateData();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('TO DO')),
      ),
      body: Column(children: [
        TextToDoField(
          onAdd: addToDOItem,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskName: db.toDoList[index][0],
                isComplete: db.toDoList[index][1],
                onChanged: (value) => checkBoxState(value, index),
                deleteFunction: (context) => deleteTask(index),
              );
            },
          ),
        ),
      ]),
    );
  }
}

class TextToDoField extends StatelessWidget {
  final Function(String) onAdd;
  final toDoController = TextEditingController();
  TextToDoField({super.key, required this.onAdd});

  void AddToDOItem() {
    if (toDoController.text != '') {
      onAdd(toDoController.text);
      toDoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 250,
            child: TextField(
              controller: toDoController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
              onPressed: () {
                AddToDOItem();
              },
              child: Text('Add TODO')),
        ],
      ),
    );
  }
}
