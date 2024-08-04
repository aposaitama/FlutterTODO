import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  Function(BuildContext)? deleteFunction;
  Function(bool?)? onChanged;
  final String taskName;
  final bool isComplete;
  ToDoTile({
    super.key,
    required this.deleteFunction,
    required this.taskName,
    required this.isComplete,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Slidable(
          startActionPane: ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(
              backgroundColor: Colors.red,
              onPressed: deleteFunction,
              label: 'Delete',
              icon: Icons.delete,
            )
          ]),
          child: Container(
            color: Colors.deepPurple[300],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Checkbox(value: isComplete, onChanged: onChanged),
                  Container(
                    child: Text(
                      taskName,
                      style: TextStyle(
                        decoration: isComplete
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
