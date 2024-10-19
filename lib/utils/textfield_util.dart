// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFieldUtil extends StatelessWidget {
  // _controller value from home_page.dart
  final TextEditingController controller;

  // saveTask() function from home_page.dart
  final VoidCallback onSubmitted;

  // constructor for getting _controller, saveTask() from home_page.dart
  const TextFieldUtil(
      {super.key, required this.controller, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    // Padds TextField to 16.0
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        // uses controller from home_page (_controller)
        controller: controller,
        decoration: InputDecoration(
          // Padds content (text) inside TextField to 16.0
          contentPadding: EdgeInsets.all(16.0),

          label: Text(
            "Add To Do",
            style: TextStyle(
                fontSize: 16, color: Theme.of(context).colorScheme.onPrimary),
          ),

          // styles border around TextField
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          // styles border around TextField when focused
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.onPrimary),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),

        // When submutted will add todo to toDoList and clear text from TextField
        // If controller.text is empty it will not add to the toDoList
        onSubmitted: (value) {
          onSubmitted();
          controller.clear();
        },
      ),
    );
  }
}
