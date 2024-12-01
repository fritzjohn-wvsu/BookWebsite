import 'package:flutter/material.dart';
import 'package:main/pages/homepage.dart';
import 'booklist.dart';

Widget navigationBar(BuildContext context) {
  return Container(
    color: const Color.fromARGB(255, 0, 15, 22), // Set background color here
    padding: const EdgeInsets.symmetric(
        vertical: 15, horizontal: 20), // Padding for better spacing
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // Left side content: Logo and LITFinds text
        Row(
          children: [
            Image.asset(
              'assets/icon.png', // Path to your icon
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {},
              child: const Text(
                'LITFinds',
                style: TextStyle(
                  color: Color(0xffe3eed4),
                  fontFamily:
                      "TanMerigue", // Ensure this font exists or choose another
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        // Middle content: Home, About, Books
        Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                ); // Add your navigation for Home page
              },
              child: const Text(
                'Home',
                style: TextStyle(color: Color(0xffe3eed4), fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                // Add your navigation for About page
              },
              child: const Text(
                'About',
                style: TextStyle(color: Color(0xffe3eed4), fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookListWidget()),
                );
              },
              child: const Text(
                'Books',
                style: TextStyle(color: Color(0xffe3eed4), fontSize: 15),
              ),
            ),
          ],
        ),
        // Right side content: Search bar and user icon
        Row(
          children: [
            // Search bar integrated directly within the navigation bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              width: 250, // Adjust width to fit the screen
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            // User icon
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Color(0xffe3eed4),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Color.fromARGB(255, 0, 15, 22),
                size: 25,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
