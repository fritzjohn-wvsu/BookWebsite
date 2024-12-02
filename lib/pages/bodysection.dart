import 'package:flutter/material.dart';

Widget bodySection() {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Section: Text Content
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main heading
              SizedBox(height: 70,),
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
                  padding: EdgeInsets.zero, // Remove default padding
                ),
                child: Container(
                  width: 200, // Fixed width for the button
                  height: 50, // Fixed height for the button
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10), // Inner padding
                  decoration: const BoxDecoration(
                    color: Color(0xffe3eed4), // Button background color
                  ),
                  child: const Center(
                    child: Text(
                      'Start Now',
                      style: TextStyle(
                        color:
                            Color.fromARGB(255, 0, 15, 22), // Button text color
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Right Section: Image
        Align(
        alignment: Alignment.topRight, // Adjust alignment to top-center
        child: SizedBox(
          width: 800, // Image width
          height: 450, // Image height
          child: Image.asset(
            'assets/pic.png', // Replace with your image asset path
            fit: BoxFit.cover, // Ensures the image fills the available space
          ),
        ),
      ),
      ],
    );
}
