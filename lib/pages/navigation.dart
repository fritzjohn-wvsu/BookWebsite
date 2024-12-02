import 'package:flutter/material.dart';
import 'package:main/pages/homepage.dart';
import 'booklist.dart';
import 'about.dart';
import 'search.dart'; // Import the Search page

Widget navigationBar(BuildContext context) {
  final TextEditingController searchController = TextEditingController();

  return Container(
    color: const Color.fromARGB(255, 0, 15, 22),
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // Left side: Logo and LITFinds
        Row(
          children: [
            Image.asset(
              'assets/icon.png',
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
                  fontFamily: "TanMerigue",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        // Middle: Home, About, Books
        Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
              child: const Text(
                'Home',
                style: TextStyle(color: Color(0xffe3eed4), fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()),
                );
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
        // Right side: Search bar and user icon
        Row(
          children: [
            // Search bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              width: 250,
              child: TextField(
                controller: searchController,
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
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Color.fromARGB(255, 0, 15, 22)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(query: searchController.text),
                        ),
                      );
                    },
                  ),
                ),
                // Add the onSubmitted callback to trigger search on Enter
                onSubmitted: (query) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(query: query),
                    ),
                  );
                },
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
