import 'package:flutter/material.dart';

Widget bodySection() {
  return Padding(
    padding: const EdgeInsets.only(left: 50), // Padding on left
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main heading
        const Text(
          "Discover Your Next Favorite",
          style: TextStyle(
            fontSize: 45,
            color: Color(0xffe3eed4),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "Book, One Recommendation",
          style: TextStyle(
            fontSize: 45,
            color: Color(0xffe3eed4),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "at a Time.",
          style: TextStyle(
            fontSize: 45,
            color: Color(0xffe3eed4),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 20),
        // Description text
        const Text(
          "Discover your next great read and explore a wide range of",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xffe3eed4),
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "genres, uncover hidden gems, and dive into captivating",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xffe3eed4),
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "stories—all in one place.",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xffe3eed4),
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 20), // Space before the button
        // Start Now button
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets
                .zero, // Remove default padding from the button itself
          ),
          child: Container(
            width: 200, // Set the fixed width for the button
            height: 50, // Set the fixed height for the button
            padding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 10), // Padding inside the button
            decoration: BoxDecoration(
              color: const Color(0xffe3eed4), // Background color of the button
            ),
            child: const Center(
              child: Text(
                'Start Now',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 15, 22), // Text color
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
