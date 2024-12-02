import 'package:flutter/material.dart';
import 'package:main/pages/homepage.dart';
import 'booklist.dart';
import 'about.dart';
import 'search.dart';
import 'package:main/pages/route_manager.dart';

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
          child: Column(
            children: [
              // Logo and Text Button positioned on the left and centered
              Row(
                mainAxisAlignment: MainAxisAlignment.start, // Aligns to the left
                crossAxisAlignment: CrossAxisAlignment.center, // Vertically centers
                children: [
                  Image.asset(
                    'assets/icon2.png',
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
                        color:Color(0xff0c1f25),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildNavItem("Home", '/home', const Homepage()),
                  const SizedBox(width: 20),
                  buildNavItem("About", '/about', const About()),
                  const SizedBox(width: 20),
                  buildNavItem("Books", '/books', BookListWidget()),
                ],
              ),
              const SizedBox(height: 20),


              // Centered copyright text
              // const Text(
              //   "© 2024, 3N1. All rights reserved.",
              //   style: TextStyle(
              //     color: Color(0xff0c1f25),
              //     fontSize: 14,
              //     fontWeight: FontWeight.bold,
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              // const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
