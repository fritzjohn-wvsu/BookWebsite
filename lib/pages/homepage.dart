import 'package:flutter/material.dart';
import 'navigation.dart'; // Import the navigation bar
import 'bodysection.dart'; // Import the body section
import 'popular.dart'; // Import the popular books section
import 'update.dart';
import 'footer.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    // Get the screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
              screenWidth * 0.01), // Adjust padding based on screen width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              navigationBar(context), // Calling the navigation bar function
              SizedBox(height: screenHeight * 0.05), // Adjust space dynamically
              bodySection(), // Calling the body section function
              SizedBox(height: screenHeight * 0.2), // Adjust space dynamically
              popularBook(), // Calling the popular books section function
              SizedBox(height: screenHeight * 0.1), // Adjust space dynamically
              updateList(),
              SizedBox(height: screenHeight * 0.1), // Adjust space dynamically
              footerPage(),
            ],
          ),
        ),
      ),
    );
  }
}
