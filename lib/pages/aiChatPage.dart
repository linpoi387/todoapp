import 'package:flutter/material.dart';
import 'package:todoapp/model/aiData.dart';
import 'package:provider/provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:todoapp/services/geminiService.dart';
import 'package:todoapp/pages/serviceSelected.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/services/huggingService.dart';
import 'package:todoapp/services/localAIService.dart';
class aiChatPage extends StatefulWidget {
  const aiChatPage({super.key});

  @override
  State<aiChatPage> createState() => _aiChatPageState();
}

class _aiChatPageState extends State<aiChatPage> {
  TextEditingController _textEditingController = TextEditingController();
  String _result = '';
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
   context.read<ChatItems>().fetchChat();
    // _result = context.read<ChatItems>().chats.last;
    
  }


 
  @override
  Widget build(BuildContext context) {
    
    final aiService = Provider.of<ChatItems>(context);
    // aiService.fetchChat();
    // print("30${aiService.chats}");
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
        child: Stack(children: [
          Markdown(
          data:aiService.chats.last??'',),
          
          Positioned(
           right: 5,
            child: IconButton(onPressed: (){
              Clipboard.setData(ClipboardData(text: aiService.chats.last));
            }, icon: Icon(Icons.copy),)),
          
        ],),
      ),
      // Text(aiService.serviceSelected.toString()),
      Row(
        children: [
          Expanded(
              child: TextField(
            controller: _textEditingController,
          )),
          CustomServiceSelect(),
          ElevatedButton(
              onPressed: () async {
                int index = aiService.serviceSelected;
                switch (index) {
                  case 0: _result =  await Geminiservice().sendRequest(_textEditingController.text);
                aiService.addChat(_result);
                 case 1: _result =  await Huggingservice().sendRequest(_textEditingController.text);
                aiService.addChat(_result);
                 case 2: _result =  await LocalAIService().sendRequest(_textEditingController.text);
                aiService.addChat(_result);
                }
             
               
                // context
                //     .read<ChatItems>()
                //     .getGeminiResult(_textEditingController.text);
                _textEditingController.clear();
              },
              child: Text('Send')),
           
        ],
      )
    ]);
  }
}
