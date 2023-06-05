import "dart:convert";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:registro/Pagine/Docenti/api_key.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:registro/mysql/Utente.dart";
import "../../metodi/Metodi.dart";
import "Classi.dart";
import "HomePageDocenti.dart";
//Pagina terminata ed Ottimizzata ✅

class AssistenteDocenti extends StatefulWidget {
  const AssistenteDocenti({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AssistenteDocentiState createState() => _AssistenteDocentiState();
}

class _AssistenteDocentiState extends State<AssistenteDocenti> {
  final List<Message> _messages = [];

  final TextEditingController _textEditingController = TextEditingController();

  void onSendMessage() async {
    Message messaggio = Message(text: _textEditingController.text, isMe: true);

    _textEditingController.clear();

    setState(() {
      _messages.insert(0, messaggio);
    });

    String response = await sendMessageToChatGpt(messaggio.text);

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


    Map<String, dynamic> parsedReponse = json.decode(response.body);

    String reply = parsedReponse["choices"][0]["message"]["content"];

    return reply;
  }

  Widget _buildMessage(Message message) {
    final Color messageColor =
        message.isMe ? sentMessageColor : receivedMessageColor;

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
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: messageColor,
                borderRadius: BorderRadius.circular(10.0.r),
              ),
              padding: EdgeInsets.all(10.0.h),
              child: Text(
                message.text,
                style: const TextStyle(color: Colors.white),
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
        title: const Text("Assistente per Docenti"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildMessage(_messages[index]);
                },
              ),
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: "Fai una domanda...",
                      border: InputBorder.none,
                    ),
                    style: GoogleFonts.roboto(color: Colors.black),
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
      bottomNavigationBar: BottomNavigationBar(
        items: [
          It("Classi", Icons.people_alt_rounded),
          It("Home", Icons.home),
          It("Assistente", Icons.help),
        ],
        onTap: (currentIndex) {
          switch (currentIndex) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Classi(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePageDocenti(),
                ),
              );
              break;
          }
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}

const Color sentMessageColor = Colors.grey;
const Color receivedMessageColor = Colors.green;
