import 'package:flutter/foundation.dart';
import 'package:todoapp/services/geminiService.dart';
import 'package:todoapp/services/huggingService.dart';
import 'package:todoapp/services/localAIService.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChatItems extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<String> _chats = ["123"];
  List<String> get chats => _chats;
  Future fetchChat() async {
    final SharedPreferences prefs = await _prefs;
    _chats = prefs.getStringList('chats')?? [""];
    // print("14$_chats");
    notifyListeners();
  }

  Future addChat(String chat) async {
    final SharedPreferences prefs = await _prefs;
    _chats.add(chat);
    await prefs.setStringList('chats', _chats);
    final result = prefs.getStringList('chats');

    notifyListeners();
  }

  void getGeminiResult(String question) async {
    await Geminiservice().sendRequest(question).then((result) {
      chats.add(result);
      notifyListeners();
    });
  }

  void getHuggingResult(String question) async {
    await Huggingservice().sendRequest(question).then((result) {
      chats.add(result);
      notifyListeners();
    });
  }

  void getLocalAIResult(String question) async {
    await LocalAIService().sendRequest(question).then((result) {
      chats.add(result);
      notifyListeners();
    });
  }
}