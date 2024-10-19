// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo_app/data/database.dart';
import 'package:todo_app/utils/edit_dialog.dart';
import 'package:todo_app/utils/textfield_util.dart';
import 'package:todo_app/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // if the app has data it will load it
    if (_myBox.get("TODOLIST") != null) {
      db.loadData();
    }

    super.initState();
  }

  // Reference to a box
  final _myBox = Hive.box("mybox");

  toDoDataBase db = toDoDataBase();

  // Controller for TextField
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[300],
      appBar: AppBar(
        title: Text(
          "TO DO",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          // TextField that adds todos
          TextFieldUtil(
            controller: controller,
            onSubmitted: saveTask,
          ),
          db.toDoList.isEmpty
              ? Expanded(
                  child: Center(
                    child: Text(
                      "No todos yet.",
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: db.toDoList.length,
                      itemBuilder: (context, index) {
                        return ToDoTile(
                          taskName: db.toDoList[index][0],
                          isCompleted: db.toDoList[index][1],
                          onChanged: (value) {
                            checkboxChanged(value, index);
                          },
                          deleteTask: (context) {
                            deleteTask(index);
                          },
                          setTask: (context) {
                            setTask(index);
                          },
                        );
                      }),
                ),
        ],
      ),
    );
  }

  // Functions

  // Adds todos to db.toDoList
  void saveTask() {
    if (controller.text.isNotEmpty) {
      setState(() {
        db.toDoList.add([controller.text, false]);
      });
      db.updateData();
    }
  }

  // Changes checkbox value
  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  // sets controller.text to the updated task text
  void setTask(index) {
    // not same thing with _controller
    TextEditingController controller = TextEditingController();

    // when dialog opens up content of textfield equals to toDoList[index][0] so we can change it
    setState(() {
      controller.text = db.toDoList[index][0];
    });

    // updates toDoList[index][0] to changed value
    void updateTask() {
      if (controller.text.isNotEmpty) {
        setState(() {
          db.toDoList[index][0] = controller.text;
        });
      } else {
        setState(() {
          db.toDoList.removeAt(index);
        });
      }
    }

    // shows dialog to edit task
    showDialog(
      context: context,
      builder: (context) => EditDialog(
        controller: controller,
        updateTask: updateTask,
      ),
    );

    // updates updates toDoList[index][0] in database
    db.updateData();
  }

  // Deletes task
  void deleteTask(index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }
}
