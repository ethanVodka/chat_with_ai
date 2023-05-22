import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final myController = TextEditingController();
  String aiResponse = '';

  Future<String> talkToAI(String message) async {
    var url = Uri.parse('your_api_endpoint');
    var response = await http.post(url, body: {'input': message});
    Map<String, dynamic> res = jsonDecode(response.body);
    return res['output'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with AI'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Text(aiResponse),
          ),
          TextField(
            controller: myController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Type your message',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              var message = myController.text;
              var reply = await talkToAI(message);
              setState(() {
                aiResponse = reply;
              });
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
