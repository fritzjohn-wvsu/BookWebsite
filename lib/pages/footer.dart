import 'package:flutter/material.dart';
import 'package:main/pages/homepage.dart';
import 'booklist.dart';
import 'about.dart';
import 'search.dart';
import 'package:main/pages/route_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import Font Awesome package

class FooterPage extends StatelessWidget {
  const FooterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Helper function to style active and inactive links
    Widget buildNavItem(String title, String routeName, Widget destination) {
      bool isActive = RouteManager.currentRoute.value == routeName;
      return TextButton(
        onPressed: () {
          // Update the current route in RouteManager
          RouteManager.currentRoute.value = routeName;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? const Color(0xff0c1f25) : const Color(0xff7a7a7a),
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
    }

    return ValueListenableBuilder<String>(
      valueListenable: RouteManager.currentRoute,
      builder: (context, currentRoute, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: const Color(0xffe3eed4), // Footer background color
          child: Padding(
            padding: const EdgeInsets.only(left: 100, right: 100), // Add left and right padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between elements
              crossAxisAlignment: CrossAxisAlignment.center, // Vertically center items
              children: [
                // Logo and Text Button on the left
                Row(
                  children: [
                    Image.asset(
                      'assets/icon2.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        RouteManager.currentRoute.value = '/home'; // Set to home route
                        Navigator.pushNamed(context, '/home'); // Navigate to home
                      },
                      child: const Text(
                        'LITFinds',
                        style: TextStyle(
                          color: Color(0xff0c1f25),
                          fontFamily: "TanMerigue",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Navbar with Links (Home, About, Books)
                Row(
                  children: [
                    buildNavItem("Home", '/home', const Homepage()),
                    const SizedBox(width: 20),
                    buildNavItem("About", '/about', const About()),
                    const SizedBox(width: 20),
                    buildNavItem("Books", '/books', BookListWidget()),
                  ],
                ),

                // Social Media Icons on the right
                Row(
                  children: [
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.facebook,
                        color: const Color.fromARGB(255, 0, 15, 22), // Set color here
                      ),
                      onPressed: () {
                        // Add your Facebook link here
                      },
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.twitter,
                        color: const Color.fromARGB(255, 0, 15, 22), // Set color here
                      ),
                      onPressed: () {
                        // Add your Twitter link here
                      },
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.pinterest,
                        color: const Color.fromARGB(255, 0, 15, 22), // Set color here
                      ),
                      onPressed: () {
                        // Add your Pinterest link here
                      },
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.instagram,
                        color: const Color.fromARGB(255, 0, 15, 22), // Set color here
                      ),
                      onPressed: () {
                        // Add your Instagram link here
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
