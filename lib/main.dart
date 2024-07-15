import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/pages/todoList.dart';
import 'package:todoapp/model/itemData.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Item(),
      child:  MainApp(),
    )
    );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ColorScheme.fromSeed(
      seedColor: Color.fromARGB(248, 250, 210, 6),
      // brightness: Brightness.dark,
      )),
      home: todoList()
    );
  }
}

