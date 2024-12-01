import 'package:flutter/material.dart';
import 'package:main/pages/homepage.dart'; // Ensure this is the correct path

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
      initialRoute: 'Homepage',
      routes: {
        'Homepage': (BuildContext ctx) => const Homepage(),
      },
    );
  }
}
