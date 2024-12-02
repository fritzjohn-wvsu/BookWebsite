import 'package:flutter/material.dart';
import 'package:main/pages/homepage.dart'; // Ensure this is the correct path
import 'package:main/pages/booklist.dart';
import 'package:main/pages/about.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LITFinds',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 10, 1, 0),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        'Homepage': (BuildContext ctx) => const Homepage(),
        '/': (context) => Homepage(),
    '/home': (context) => Homepage(),
    '/about': (context) => About(),
    '/books': (context) => BookListWidget(),
      },
    );
  }
}
