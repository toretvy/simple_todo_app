// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class EditDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback updateTask;

  const EditDialog({
    super.key,
    required this.controller,
    required this.updateTask,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // color of Dialog
      backgroundColor: Colors.lightGreen[300],

      title: Text("Edit task:"),

      content: TextField(
        // copy of controller from setTask() in home_page.dart
        controller: controller,

        decoration: InputDecoration(
          // styles border around TextField when focused
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.onPrimary),
            borderRadius: BorderRadius.circular(10.0),
          ),

          // styles border around TextField
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),

      // padds content of Dialog
      contentPadding: EdgeInsets.all(16.0),

      // buttons (cancel and edit)
      actions: [
        ElevatedButton(
            onPressed: () {
              // closes dialog
              Navigator.of(context).pop();

              // clears controller.text
              controller.clear();
            },

            // content of button
            child: Text(
              "CANCEL",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),

            // changes color of button
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            )),
        ElevatedButton(
            onPressed: () {
              // updates tass with controller.text
              updateTask();

              // clears controller.text
              controller.clear();

              // closes dialog
              Navigator.of(context).pop();
            },

            // content of button
            child: Text("EDIT",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary)),

            // changes color of button
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            )),
      ],
    );
  }
}
