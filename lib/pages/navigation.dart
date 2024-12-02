import 'package:flutter/material.dart';
import 'package:main/pages/homepage.dart';
import 'booklist.dart';
import 'about.dart';
import 'search.dart'; // Import the Search page

Widget navigationBar(BuildContext context) {
  final TextEditingController searchController = TextEditingController();

  // Get the current route or default to '/home' if no route is set
  String currentRoute = ModalRoute.of(context)?.settings.name ?? '/home';

  // Function to style the nav item with hover effect
  Widget buildNavItem(String title, String routeName) {
    bool isActive = currentRoute == routeName;
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, routeName);
      },
      style: TextButton.styleFrom(
        backgroundColor: isActive ? const Color(0xffe3eed4) : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive
              ? const Color.fromARGB(255, 0, 15, 22)
              : const Color(0xffe3eed4),
          fontSize: 15,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

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
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
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
            buildNavItem('Home', '/home'),
            const SizedBox(width: 30),
            buildNavItem('About', '/about'),
            const SizedBox(width: 30),
            buildNavItem('Books', '/books'),
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
                  fillColor: const Color(0xffe3eed4),
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
