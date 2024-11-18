import 'package:flutter/material.dart';

Widget popularBook() {
  return Center(
    child: Container(
      width: 1450,
      height: 700, // Set the width of the new container to match the button
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(
            255, 0, 15, 22), // Background color for new page section
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular Today Title
          const Text(
            "Popular Today",
            style: TextStyle(
              fontSize: 30,
              color: Color(0xffe3eed4),
              fontWeight: FontWeight.bold,
            ),
          ),
          // Divider line under the title
          const Divider(
            color: Color(0xffe3eed4), // Color of the line
            thickness: 1, // Thickness of the line
            height: 20, // Space between the text and the line
          ),
          const SizedBox(height: 10),
          // Row of small rectangles with text below
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Repeated Columns for Books 1-5
              _bookRectangle('Book 1'),
              _bookRectangle('Book 2'),
              _bookRectangle('Book 3'),
              _bookRectangle('Book 4'),
              _bookRectangle('Book 5'),
            ],
          ),
        ],
      ),
    ),
  );
}

// Helper widget to create a rectangle for each book
Widget _bookRectangle(String bookName) {
  return Column(
    children: [
      Container(
        width: 200,
        height: 300,
        color: const Color(0xffe3eed4),
      ),
      const SizedBox(height: 8),
      Text(
        bookName,
        style: const TextStyle(
          color: Color(0xffe3eed4),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      // Row for the review number, star icon, and ongoing status
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Number of reviews
          const Text(
            '10',
            style: TextStyle(
              color: Color(0xffe3eed4),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          // Star icon
          const Icon(
            Icons.star,
            color: Colors.yellow,
            size: 16,
          ),
          const SizedBox(width: 100),
          // Ongoing text
          const Text(
            'Ongoing',
            style: TextStyle(
              color: Color(0xffe3eed4),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ],
  );
}
