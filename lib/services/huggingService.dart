import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Huggingservice {
  final huggingFaceAPI = dotenv.env['HugginFace'];

  Future<String> sendRequest(String question) async {
    var url = Uri.parse(
        "https://api-inference.huggingface.co/models/mistralai/Mistral-7B-Instruct-v0.2/v1/chat/completions");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $huggingFaceAPI'
    };

    final textInput = {
      "model": "mistralai/Mistral-7B-Instruct-v0.2",
      "messages": [
        {"role": "user", "content": "$question"}
      ],
      "max_tokens": 500,
      "stream": false
    };
    String result = '';
    var response =
        await http.post(url, body: jsonEncode(textInput), headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      result = jsonDecode(response.body)['choices'][0]['message']['content'];
    } else {
      throw Exception("Failed to add todo");
    }
    return result;
  }
}