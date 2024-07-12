import 'package:flutter/material.dart';
import 'package:todoapp/pages/todoList.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.cyan,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(248, 177, 151, 22),
              brightness: Brightness.light,
        )),
        home: todoList());
  }
}
