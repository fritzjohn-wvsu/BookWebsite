import 'package:flutter/material.dart';
import 'navigation.dart';
import 'footer.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    // Using MediaQuery for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
      body: SingleChildScrollView(
        // Wrap the content with SingleChildScrollView  to avoid overflow
        child: Column(
          children: [
            // Include the navigation bar at the top
            navigationBar(),
            // The rest of the page content
            Center(
              child: Container(
                width: 1450,
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
                          const SizedBox(width: 50),
                          _buildTextSection(),
                        ],
                      )
                    else
                      Column(
                        children: [
                          _buildImageSection(),
                          const SizedBox(height: 20),
                          _buildTextSection(),
                        ],
                      ),
                  ],
                ),
              ),
            ),
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
          'assets/icon1.png',
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
            'LITFinds',
            style: TextStyle(
              color: Color(0xffe3eed4),
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'Serif',
            ),
          ),
          SizedBox(height: 20),
          Text(
            'LITFinds is a web-based book recommendation application that '
            'allows users to explore and uncover books across a wide range of genres. '
            'Whether you love mysteries, thrillers, or romantic tales, LITFinds has the perfect recommendation waiting for you.',
            style: TextStyle(
              color: Color(0xffe3eed4),
              fontSize: 20,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
