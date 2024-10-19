// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ToDoTile extends StatelessWidget {
  // toDoList[index][0] value from home_page.dart
  final String taskName;

  // toDoList[index][1] value from home_page.dart
  final bool isCompleted;

  // checkboxChanged() function from home_page.dart
  Function(bool?)? onChanged;

  // deleteTask() function from home_page.dart
  Function(BuildContext)? deleteTask;

  // setTask() function from home_page.dart
  Function(BuildContext)? setTask;

  // constructor for getting values from home_page.dart
  ToDoTile(
      {super.key,
      required this.taskName,
      required this.isCompleted,
      required this.onChanged,
      required this.deleteTask,
      required this.setTask});

  @override
  Widget build(BuildContext context) {
    // Padds everthing except the top to 16.0
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
      child: Slidable(
        startActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: setTask,
            icon: Icons.edit,
            backgroundColor: Colors.green,
            borderRadius: BorderRadius.circular(10.0),
          )
        ]),
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteTask,
            icon: Icons.delete,
            backgroundColor: Colors.red.shade400,
            borderRadius: BorderRadius.circular(10.0),
          )
        ]),
        child: Container(
          // Padds content of Container to 16.0
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            // Round corners of Container to 10.0
            borderRadius: BorderRadius.circular(10.0),

            // Changes color to primary color of app
            color: Theme.of(context).primaryColor,
          ),
          // Row for Text of task and Checkbox
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // spaces Text and Checkbox to sides
            children: [
              // Expands text to the left and chekbox to the right
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).colorScheme.onPrimary,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                  overflow:
                      TextOverflow.clip, // Add ellipsis if text is too long
                ),
              ),
              Checkbox(value: isCompleted, onChanged: onChanged),
            ],
          ),
        ),
      ),
    );
  }
}
