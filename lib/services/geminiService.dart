import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todoapp/model/aiData.dart';

class Geminiservice {

  final GOOGLE_API_KEY = dotenv.env['GOOGLE_API_KEY'];
  
  Future<String> sendRequest(String question) async {
    var url = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$GOOGLE_API_KEY");
    var headers = {'Content-Type': 'application/json'};

    final textInput = {
      "contents": [
        {
          "parts": [
            {"text": '$question'}
          ]
        }
      ]
    };
    String result = '';
    var response =
        await http.post(url, body: jsonEncode(textInput), headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      result = jsonDecode(response.body)['candidates'][0]['content']['parts'][0]['text'];
      
    }
    else{
      throw Exception("Failed to add todo");
    }
    return result;
  }
  
}
