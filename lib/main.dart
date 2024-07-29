import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoapp/pages/todoList.dart';
import 'package:todoapp/model/itemData.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todoapp/model/aiData.dart';

void main()async{
  await dotenv.load(fileName: ".env");
  
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(
        create: (context) => Item()),
        ChangeNotifierProvider(create: (context)=>ChatItems())
        ],
        child:  MainApp(),
      ),
    
    );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ColorScheme.fromSeed(
      seedColor: Color.fromARGB(84, 215, 2, 2),
      brightness: Brightness.light,)),
      home: todoList()
    );
  }
}

