import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Quotes',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> quotes = [];
  int currentIndex = 0;
  DateTime? lastUpdatedDate;

  @override
  void initState() {
    super.initState();
    loadQuotes().then((_) {
      checkAndUpdateQuote();
    });
  }

  Future<void> loadQuotes() async {
    String jsonData = await rootBundle.loadString('assets/data/Quotes.json');
    quotes = jsonDecode(jsonData);
  }

  Future<void> checkAndUpdateQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime? currentDate = DateTime.now();

    lastUpdatedDate = prefs.getString('lastUpdatedDate') != null
        ? DateTime.parse(prefs.getString('lastUpdatedDate')!)
        : null;

    if (lastUpdatedDate == null || !isSameDay(lastUpdatedDate!, currentDate)) {
      currentIndex = 0;
      prefs.setString('lastUpdatedDate', currentDate.toString());
    }

    setState(() {});
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void copyToClipboard() {
    Clipboard.setData(
        ClipboardData(text: quotes[currentIndex]['quote'].toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Quote copied to clipboard'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Quotes'),
      ),
      body: quotes.isNotEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      quotes[currentIndex]['quote'],
                      style: const TextStyle(fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      '- ${quotes[currentIndex]['speaker']}',
                      style: const TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: copyToClipboard,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentIndex = (currentIndex + 1) % quotes.length;
                });
              },
              child: const Text('Next Quote'),
            ),
          ],
        ),
      ),
    );
  }
}