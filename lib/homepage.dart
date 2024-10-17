import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  _TodoList createState() => _TodoList();
}

class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}

class _TodoList extends State<TodoList> {
  List<Task> tasks = [];
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _addNewTask(String taskTitle) {
      if (taskTitle.isNotEmpty) {
        setState(() {
          tasks.add(Task(title: taskTitle));
        });
        _taskController.clear();
      }
    }

    void _deleteTask(int index) {
      debugPrint('Deleting task at index: $index');
      setState(() {
        tasks.removeAt(index);
      });
    }

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        middle: Text(
          "To-Do List",
          style: TextStyle(color: CupertinoColors.white),
        ),
      ),
      backgroundColor: CupertinoColors.black,
      child: Center(
        child: CupertinoButton(
          color: const Color.fromARGB(255, 255, 133, 33),
          child: const Text("Add your entries"),
          onPressed: () {
            showGeneralDialog(
              context: context,
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      width: 500,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(244, 61, 55, 55),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.transparent,
                            blurRadius: 10,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: tasks.isEmpty
                                ? Center(
                                    child: Text('No Tasks',
                                        style: TextStyle(fontSize: 20)))
                                : ListView.builder(
                                    itemCount: tasks.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        child: CupertinoListTile(
                                          title: Text(tasks[index].title),
                                          trailing: CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () => setState(() {
                                              _deleteTask(index);
                                            }),
                                            child: Icon(CupertinoIcons.delete,
                                                color:
                                                    CupertinoColors.systemRed),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          const Text(
                            "Add New Task",
                            style: TextStyle(
                              color: CupertinoColors.activeOrange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          CupertinoTextField(
                            controller: _taskController,
                            placeholder: "Add Item",
                            placeholderStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.extraLightBackgroundGray,
                            ),
                            decoration: BoxDecoration(
                              color: CupertinoColors.transparent,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          CupertinoButton(
                            color: CupertinoColors.activeOrange,
                            onPressed: () {
                              _addNewTask(_taskController.text);
                              Navigator.pop(context); // Close dialog
                            },
                            child: const Text("Enter"),
                          ),
                          const SizedBox(height: 10),
                          // Separate cancel button to close the dialog
                          CupertinoButton(
                            color: CupertinoColors.black,
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                            },
                            child: const Text("Cancel"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              barrierDismissible: true,
              barrierLabel: 'Dismiss',
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: const Duration(milliseconds: 300),
              transitionBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
