import 'package:flutter/material.dart';

class BackgroundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,  // Makes the image fill the screen
        children: [
          // Background image
          Image.asset(
            'assets/LitFinds.png', // Replace with your image path
            fit: BoxFit.cover,  // Ensures the image covers the entire screen
          ),
        ],
      ),
    );
  }
}
