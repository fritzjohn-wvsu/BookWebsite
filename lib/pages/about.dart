import 'package:flutter/material.dart';
import 'navigation.dart'; // Import your navigationBar widget
import 'footer.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
      body: Column(
        children: [
          // Include the navigation bar at the top
          navigationBar(context),
          // The rest of the page content
          Expanded(
            child: Center(
              child: Container(
                width: screenWidth > 600 ? 900 : screenWidth * 0.9, // Responsive width
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
                          const SizedBox(width: 50), // Space between image and text
                          _buildTextSection(),
                        ],
                      )
                    else
                      Column(
                        children: [
                          _buildImageSection(),
                          const SizedBox(height: 20), // Space between image and text
                          _buildTextSection(),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Footer section
          footerPage(),
        ],
      ),
    );
  }

  // Method for building the image section
  Widget _buildImageSection() {
    return Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 0, 15, 22),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/icon.png', // Ensure this path is correct
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
            'LitFinds',
            style: TextStyle(
              color: Color.fromARGB(255, 253, 254, 254),
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'Serif',
            ),
          ),
          SizedBox(height: 20),
          Text(
            'LitFinds is a web-based book recommendation application that '
            'allows users to explore and uncover books across a wide range of genres. '
            'Whether you love mysteries, thrillers, or romantic tales, LitFinds has the perfect recommendation waiting for you.',
            style: TextStyle(
              color: Color.fromARGB(255, 253, 254, 254),
              fontSize: 20,
              height: 1.5, // Improves line spacing for readability
            ),
          ),
        ],
      ),
    );
  }
}


