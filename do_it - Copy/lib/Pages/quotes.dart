import 'dart:convert';
import 'package:do_it/data/end_point.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  String _quote = "Click the button to get inspired!";
  String _author = "";

  String pathUrl = "${EndPoint.baseUrl}${EndPoint.quotes}";

  Future<void> fetchQuote() async {
    final response = await http.get(
      Uri.parse(pathUrl),
      headers: {'X-Api-Key': EndPoint.apiKey},
    );

    if (response.statusCode == 200) {
      List<dynamic> quotes = jsonDecode(response.body);

      setState(() {
        _quote = quotes[0]['quote'];
        _author = quotes[0]['author'];
      });
    } else {
      setState(() {
        _quote = "Failed to fetch quote. Please try again.";
        _author = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Motivational Quotes",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _quote,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _author.isNotEmpty ? "- $_author" : "",
                style:
                    const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: fetchQuote,
                child: const Text("Get Motivated"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
