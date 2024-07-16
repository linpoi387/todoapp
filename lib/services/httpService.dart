import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:todoapp/model/itemData.dart';

class HttpService {
  Future<Map<String, Item>> getTodos() async {
    var url = Uri.parse("http://127.0.0.1:5000/todos");
    var response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception("Failed to load todos");
    } else {
      Map<String, dynamic> data = (json.decode(response.body));
      print(data);
      Map<String, Item> todoItems = data.map((key, value) {
        return MapEntry(
            key,
            Item(
                title: value['title'],
                description: value['description'],
                todoValue: value['todoValue']));
      });
      return todoItems;
    }
  }

  Future<void> postTodo(Map data) async {
    var url = Uri.parse("http://127.0.0.1:5000/todos");
    var headers = {'Content-Type': 'application/json'};
    var response =
        await http.post(url, body: jsonEncode(data), headers: headers);
    if (response.statusCode!= 200) {
      throw Exception("Failed to add todo");
    }
    
    
  }

  Future<void> updateTodo(Item data) async {
    var url = Uri.parse("http://127.0.0.1:5000/todos/${data.title}");
    var headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> dataMap = {
      'title': data.title,
      'description': data.description,
      'todoValue': data.todoValue
    };
    var response =
        await http.put(url, body: jsonEncode(dataMap), headers: headers);
    print(response.body);
  }

  Future<void> deleteTodo(String title) async {
    var url = Uri.parse("http://127.0.0.1:5000/todos/$title");
    var response = await http.delete(url);
    print(response.body);
  }
}
