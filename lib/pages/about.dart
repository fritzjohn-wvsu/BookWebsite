import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'navigation.dart'; // Import your navigationBar widget
import 'footer.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
=======
import 'navigation.dart';
import 'footer.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
>>>>>>> 811cc2b85b54d146a2c9c4f2279e0e9e82174898
  Widget build(BuildContext context) {
    // Using MediaQuery for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
<<<<<<< HEAD
      body: SingleChildScrollView( // Wrap the content with SingleChildScrollView
=======
      body: SingleChildScrollView( // Wrap the content with SingleChildScrollView  to avoid overflow
>>>>>>> 811cc2b85b54d146a2c9c4f2279e0e9e82174898
        child: Column(
          children: [
            // Include the navigation bar at the top
            navigationBar(context),
            // The rest of the page content
            Center(
              child: Container(
<<<<<<< HEAD
                width: 1450, // Responsive width
=======
                width: 1450, 
>>>>>>> 811cc2b85b54d146a2c9c4f2279e0e9e82174898
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image and text sections side by side for wide screens
                    if (screenWidth > 600)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildImageSection(),
<<<<<<< HEAD
                          const SizedBox(width: 50), // Space between image and text
=======
                          const SizedBox(width: 50),
>>>>>>> 811cc2b85b54d146a2c9c4f2279e0e9e82174898
                          _buildTextSection(),
                        ],
                      )
                    else
                      Column(
                        children: [
                          _buildImageSection(),
<<<<<<< HEAD
                          const SizedBox(height: 20), // Space between image and text
=======
                          const SizedBox(height: 20), 
>>>>>>> 811cc2b85b54d146a2c9c4f2279e0e9e82174898
                          _buildTextSection(),
                        ],
                      ),
                  ],
                ),
              ),
            ),
<<<<<<< HEAD
            // Footer section
            footerPage(),
=======
            const Text(
                "© 2024, 3N1. All rights reserved.",
                style: TextStyle(
                  color: Color(0xffe3eed4),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
            // Footer section
            FooterPage(),
>>>>>>> 811cc2b85b54d146a2c9c4f2279e0e9e82174898
          ],
        ),
      ),
    );
  }

  // Method for building the image section
  Widget _buildImageSection() {
    return Container(
      width: 300,
      height: 500,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 0, 15, 22),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
<<<<<<< HEAD
          'assets/icon.png', // Ensure this path is correct
=======
          'assets/icon1.png',
>>>>>>> 811cc2b85b54d146a2c9c4f2279e0e9e82174898
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Method for building the text section
  Widget _buildTextSection() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
<<<<<<< HEAD
            'LitFinds',
            style: TextStyle(
              color: Color.fromARGB(255, 253, 254, 254),
=======
            'LITFinds',
            style: TextStyle(
              color: Color(0xffe3eed4),
>>>>>>> 811cc2b85b54d146a2c9c4f2279e0e9e82174898
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'Serif',
            ),
          ),
          SizedBox(height: 20),
          Text(
<<<<<<< HEAD
            'LitFinds is a web-based book recommendation application that '
            'allows users to explore and uncover books across a wide range of genres. '
            'Whether you love mysteries, thrillers, or romantic tales, LitFinds has the perfect recommendation waiting for you.',
            style: TextStyle(
              color: Color.fromARGB(255, 253, 254, 254),
              fontSize: 20,
              height: 1.5, // Improves line spacing for readability
=======
            'LITFinds is a web-based book recommendation application that '
            'allows users to explore and uncover books across a wide range of genres. '
            'Whether you love mysteries, thrillers, or romantic tales, LITFinds has the perfect recommendation waiting for you.',
            style: TextStyle(
              color: const Color(0xffe3eed4),
              fontSize: 20,
              height: 1.5, 
>>>>>>> 811cc2b85b54d146a2c9c4f2279e0e9e82174898
            ),
          ),
        ],
      ),
    );
  }
}
