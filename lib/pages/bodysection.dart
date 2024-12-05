import 'package:flutter/material.dart';
import 'route_manager.dart';

Widget bodySection(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Section: Text Content
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                const Text(
                  "Discover Your Next Favorite",
                  style: TextStyle(
                    fontSize: 45,
                    color: Color(0xffe3eed4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Book, One Recommendation",
                  style: TextStyle(
                    fontSize: 45,
                    color: Color(0xffe3eed4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "at a Time.",
                  style: TextStyle(
                    fontSize: 45,
                    color: Color(0xffe3eed4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Discover your next great read and explore a wide range of",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffe3eed4),
                  ),
                ),
                const Text(
                  "genres, uncover hidden gems, and dive into captivating",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffe3eed4),
                  ),
                ),
                const Text(
                  "stories—all in one place.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffe3eed4),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Set route to Books and navigate
                    RouteManager.currentRoute.value = '/books';
                    Navigator.pushNamed(context, '/books');
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color(0xffe3eed4),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Center(
                      child: Text(
                        'Start Now',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 15, 22),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right Section: Image
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: 800,
            height: 450,
            child: Image.asset(
              'assets/pic.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );
}
