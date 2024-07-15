import 'package:flutter/material.dart';
import 'package:todoapp/pages/addTodo.dart';
import 'package:todoapp/utils/colorSetting.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/itemData.dart';
class todoList extends StatefulWidget {
  const todoList({super.key});

  @override
  State<todoList> createState() => _todoListState();
}

class _todoListState extends State<todoList> {
 

  @override
  void initState() {
    super.initState();
    //  data2 = Provider.of<Item>(context);
     print("data2${context.read<Item>().data}");
    
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<Item>().data;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo APP'),
      ),
      body: ListView(
        children: [
          ...data.entries.map((e)=>
            _todoListTile(e.value.title!, e.value.description!, e.value.todoValue!)
          ) 
        ],
      )
      ,
      floatingActionButton: FloatingActionButton(
        backgroundColor: todoAppColor().second,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () async {
            final result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return AddTodo();
            }));
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text(result!=null ? result['title']:"Data Build"),
            // ));
             if (result != null && result['title'] != ''){final addValue = {"${result["title"]}":
                Item(title:result["title"], description:result["description"], todoValue: false)
                };
          context.read<Item>().addData(addValue);
          print(context.read<Item>().data);}
              
           

            // setState(() {
            //   if (result != null && result['title'] != '')
            //     data[result["title"]] = {
            //       "title": result["title"],
            //       "description": result["description"],
            //       "todoValue": false,
            //     };
            // });
          },
          child: Icon(Icons.add)),
    );
  }

  

  Card _todoListTile(String title, String description, bool todoValue) => Card(
          child: ListTile(
        leading: Checkbox(
            onChanged: (bool? value) {
               final data = context.read<Item>().data;
               data[title] = Item(title:title, description: description, todoValue:value);
               context.read<Item>().addData(data);
               print(context.read<Item>().data[title]!.todoValue);
              // setState(() {
              //   data[title]['todoValue'] = value;
              // });
            },
            value: todoValue),
        title: Text(title),
        subtitle: Text(description),
        trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              final data = context.read<Item>().data;
             
              context.read<Item>().deleteData(title);
              // setState(() {
              //   data.remove(title);
              // });
            }),
      ));
}
