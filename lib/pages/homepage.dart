import 'package:flutter/material.dart';
import 'navigation.dart'; // Import the navigation bar
import 'bodysection.dart'; // Import the body section
import 'popular.dart'; // Import the popular books section

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              navigationBar(), // Calling the navigation bar function
              const SizedBox(height: 100), // Space between sections
              bodySection(), // Calling the body section function
              const SizedBox(height: 200), // Space between sections
              popularBook(), // Calling the popular books section function
            ],
          ),
        ),
      ),
    );
  }
}
