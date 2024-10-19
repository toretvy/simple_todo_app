import 'package:hive_flutter/hive_flutter.dart';

class toDoDataBase {
  List toDoList = [];

  // Reference a hive box
  final _myBox = Hive.box("mybox");

  // run this method if this is the 1st time ever opening this app
  void createInitData() {}

  // load the data
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the data
  void updateData() {
    _myBox.put("TODOLIST", toDoList);
  }
}
