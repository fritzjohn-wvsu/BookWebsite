import 'package:flutter/material.dart';
import 'navigation.dart';
import 'bodysection.dart'; 
import 'popular.dart'; 
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
        
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              navigationBar(context), // Calling the navigation bar function
              SizedBox(height: screenHeight * 0.05), 
              bodySection(context), // Calling the body section function
              SizedBox(height: screenHeight * 0.2), 
              popularBook(), // Calling the popular books section function
              SizedBox(height: screenHeight * 0.1), 
              updateList(context),// call the updatelis
              SizedBox(height: screenHeight * 0.1), 
              FooterPage(),//call the footer
            ],
          ),
      ),
    );
  }
}
