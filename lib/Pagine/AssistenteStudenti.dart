import "dart:convert";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:http/http.dart" as http;
import "package:registro/mysql/Utente.dart";

import "Widget/APIKey.dart";

class AssistenteStudenti extends StatefulWidget {
  const AssistenteStudenti({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AssistenteStudentiState createState() => _AssistenteStudentiState();
}

class _AssistenteStudentiState extends State<AssistenteStudenti> {
  final List<Message> _messages = [];
  final TextEditingController _textEditingController = TextEditingController();

  void onSendMessage() async {
    Message message = Message(text: _textEditingController.text, isMe: true);
    _textEditingController.clear();
    setState(() {
      _messages.insert(0, message);
    });

    String response = await sendMessageToChatGpt(message.text);
    Message chatGpt = Message(text: response, isMe: false);
    setState(() {
      _messages.insert(0, chatGpt);
    });
  }

  Future<String> sendMessageToChatGpt(String message) async {
    Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");

    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": message}
      ],
      "max_tokens": 500,
    };

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${APIKey.apiKey}",
      },
      body: json.encode(body),
    );

    Map<String, dynamic> parsedResponse = json.decode(response.body);

    String? reply =
        parsedResponse["choices"]?[0]["message"]?["content"] as String?;

    if (reply == null) {
      throw Exception("Failed to parse response");
    }

    return reply;
  }

  Widget _buildMessage(Message message) {
    Color backgroundColor = message.isMe ? Colors.green : Colors.blue;
    Color textColor = message.isMe ? Colors.white : Colors.black;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0.w),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment:
              message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.isMe ? nome_ : "Assistente",
              style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
            ),
            Container(
              padding: EdgeInsets.all(10.0.h),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                message.text,
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assistente Studente"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Divider(height: 1.0.h),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: "Fai qualche domanda",
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: onSendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey,
    );
  }
}

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}
