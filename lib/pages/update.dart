import 'package:flutter/material.dart';

Widget updateList() {
  return Center(
    child: SingleChildScrollView(
      // Wrap the whole container in a scroll view
      child: Container(
        width: 1450,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 15, 22),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Latest Updates Title (Aligned to the left)
            const Text(
              "Latest Updates",
              style: TextStyle(
                fontSize: 30,
                color: Color(0xffe3eed4),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              color: Color(0xffe3eed4),
              thickness: 1,
              height: 20,
            ),
            const SizedBox(height: 10),
            // Row with two book details spaced evenly
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Space items evenly
              children: [
                _bookDetailWithImage('Book 1'),
                _bookDetailWithImage('Book 2'),
              ],
            ),
            const SizedBox(height: 20),
            // Row with Book 3 and Book 4
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Space items evenly
              children: [
                _bookDetailWithImage('Book 3'),
                _bookDetailWithImage('Book 4'),
              ],
            ),
            const SizedBox(height: 20),
            // Center the "View all Updates" container below Book 3 and Book 4
            Center(
              child: Container(
                alignment:
                    Alignment.center, // Align the content inside the container
                width: 350, // Resized width
                height: 50, // Resized height
                margin: const EdgeInsets.only(
                    bottom: 15), // Inset left margin handled at the row level
                decoration: BoxDecoration(
                  color: const Color(0xffc1d5e0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "View all Updates",
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _bookDetailWithImage(String bookName) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center items in the row
        children: [
          // Book Image Rectangle
          Container(
            width: 200,
            height: 300,
            color: const Color(0xffe3eed4),
            child: const Icon(
              Icons.image,
              color: Colors.black,
              size: 80,
            ),
          ),
          const SizedBox(width: 20), // Adjusted width between image and text
          // Book Details Rectangle with padding inside
          Container(
            width: 400,
            height: 300,
            padding: const EdgeInsets.all(
                12), // Add padding inside the description rectangle
            decoration: BoxDecoration(
              color: const Color(0xffe3eed4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book Title (Left-aligned)
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 3),
                  child: Text(
                    bookName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Row with rating, star, and ongoing status (no space between elements)
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20), // Added left padding
                      child: Text(
                        '10',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 15,
                    ),
                    Spacer(), // Spacer to push the 'Ongoing' text to the right
                    Padding(
                      padding:
                          EdgeInsets.only(right: 15), // Adjust right padding
                      child: Text(
                        'Ongoing',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // List of Chapter Rectangles inside the book details (Resize chapters)
                Center(
                  // Center the chapter rectangles
                  child: Column(
                    children: [
                      _chapterRectangle('Chapter 1'),
                      _chapterRectangle('Chapter 2'),
                      _chapterRectangle('View All'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget _chapterRectangle(String chapterName) {
  return Container(
    width: 350, // Resized width
    height: 50, // Resized height
    margin: const EdgeInsets.only(
        bottom: 15), // Inset left margin handled at the row level
    decoration: BoxDecoration(
      color: const Color(0xffc1d5e0),
      borderRadius: BorderRadius.circular(20),
    ),
    alignment: Alignment.center,
    child: Text(
      chapterName,
      style: const TextStyle(
        color: Color(0xff000000),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
