import 'package:flutter/material.dart';
import 'package:todoapp/pages/addTodo.dart';

class todoList extends StatefulWidget {
  const todoList({super.key});

  @override
  State<todoList> createState() => _todoListState();
}

class _todoListState extends State<todoList> {
  Map data = {
    "test1": {"title": "test1", "description": "ABC1", "todoValue": true},
    "test2": {"title": "test2", "description": "ABC2", "todoValue": false},
    "test3": {"title": "test3", "description": "ABC3", "todoValue": false},
  };

  @override
  void initState() {
    super.initState();
    print("data長度${data.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo APP'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _todoList(data)[index];
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () async {
            final result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return AddTodo();
            }));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(result!=null ? result['title']:"Data Build"),
            ));

            setState(() {
              if (result != null && result['title'] != '')
                data[result["title"]] = {
                  "title": result["title"],
                  "description": result["description"],
                  "todoValue": false,
                };
            });
          },
          child: Icon(Icons.add)),
    );
  }

  List<Card> _todoList(Map data) => data.entries.map((e) {
        return _todoListTile(
            e.value['title'], e.value['description'], e.value['todoValue']);
      }).toList();

  Card _todoListTile(String title, String description, bool todoValue) => Card(
          child: ListTile(
        leading: Checkbox(
            onChanged: (bool? value) {
              setState(() {
                data[title]['todoValue'] = value;
              });
            },
            value: todoValue),
        title: Text(title),
        subtitle: Text(description),
        trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                data.remove(title);
              });
            }),
      ));
}
