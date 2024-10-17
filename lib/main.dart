import 'package:flutter/cupertino.dart';
import 'package:todo_list/homepage.dart';

void main() {
  runApp(const CupertinoApp(
    home: CupertinoPageScaffold(child: TodoList()),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoPageScaffold(
        child: Center(
          child: TodoList(),
        ),
      ),
    );
  }
}
