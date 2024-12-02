import 'package:flutter/material.dart';
import 'package:main/pages/homepage.dart';
import 'booklist.dart';
import 'about.dart';
import 'search.dart'; // Import the Search page
import 'package:main/pages/route_manager.dart';


Widget navigationBar(BuildContext context) {
  final TextEditingController searchController = TextEditingController();

  // Function to style the nav item with active state
  Widget buildNavItem(String title, String routeName) {
    return ValueListenableBuilder<String>(
      valueListenable: RouteManager.currentRoute,
      builder: (context, currentRoute, child) {
        bool isActive = currentRoute == routeName;
        return TextButton(
          onPressed: () {
            RouteManager.currentRoute.value = routeName;
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
      },
    );
  }

  return Container(
    color: const Color.fromARGB(255, 0, 15, 22),
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo and LITFinds
        Row(
          children: [
            Image.asset(
              'assets/icon1.png',
              width: 35,
              height: 35,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                RouteManager.currentRoute.value = '/';
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
        // Nav items
        Row(
          children: [
            buildNavItem('Home', '/home'),
            const SizedBox(width: 30),
            buildNavItem('About', '/about'),
            const SizedBox(width: 30),
            buildNavItem('Books', '/books'),
          ],
        ),
        // Search bar and user icon
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
