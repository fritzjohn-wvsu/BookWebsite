import 'package:flutter/material.dart';

Widget popularBook() {
  return Center(
    child: SingleChildScrollView(
      // Wrap the whole container in a scroll view to allow scrolling
      child: Container(
        width: 1450,
        decoration: BoxDecoration(
          color: const Color.fromARGB(
              255, 0, 15, 22), // Background color for the section
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
            const SizedBox(
              height: 25,
            ),
            // Row of small rectangles with text below (Books 1 to 5)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _bookRectangle('Book 1'),
                _bookRectangle('Book 2'),
                _bookRectangle('Book 3'),
                _bookRectangle('Book 4'),
                _bookRectangle('Book 5'),
              ],
            ),
            const SizedBox(
              height: 25,
            ), // Row of small rectangles with text below (Books 6 to 10)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _bookRectangle('Book 6'),
                _bookRectangle('Book 7'),
                _bookRectangle('Book 8'),
                _bookRectangle('Book 9'),
                _bookRectangle('Book 10'),
              ],
            ),
          ],
        ),
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
      // Book name below the image
      Text(
        bookName,
        style: const TextStyle(
          color: Color(0xffe3eed4),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      // Row for the review number, star icon, and ongoing status
      const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Number of reviews
          Text(
            '10',
            style: TextStyle(
              color: Color(0xffe3eed4),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5),
          // Star icon
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 16,
          ),
          SizedBox(width: 100),
          // Ongoing text
          Text(
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
