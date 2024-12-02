import 'package:flutter/material.dart';
import 'package:main/pages/homepage.dart';
import 'booklist.dart';
import 'about.dart';
import 'search.dart';

class footerPage extends StatelessWidget {
  const footerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: const Color(0xffe3eed4), // Footer background color changed
      child: Column(
        children: [
          // Row for Navbar with Links (Home, About, Books)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
                },
                child: const Text(
                  "Home",
                  style: TextStyle(
                    color: Color(0xff0c1f25), // Text color changed
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()),
                );
                },
                child: const Text(
                  "About",
                  style: TextStyle(
                    color: Color(0xff0c1f25), // Text color changed
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookListWidget()),
                );
                },
                child: const Text(
                  "Books",
                  style: TextStyle(
                    color: Color(0xff0c1f25), // Text color changed
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Row for Email Subscription and Copyright Notice
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side: Email subscription container
              Container(
                width: 500,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 15,
                      22), // Dark color for the email subscription container
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    // Text for Email Subscription
                    const Expanded(
                      child: Text(
                        "Subscribe to our newsletter:",
                        style: TextStyle(
                          color: Color(0xffe3eed4), // Text color changed
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Email input field
                    SizedBox(
                      width: 200,
                      child: TextField(
                        style: const TextStyle(
                          color:
                              Colors.white, // Change input text color to white
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          hintStyle: const TextStyle(
                            color: Color(
                                0xffe3eed4), // Hint text color changed to light color
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(
                                  0xffe3eed4), // Border color when enabled
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(
                                  0xffe3eed4), // Border color when focused
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Subscribe Button
                    IconButton(
                      onPressed: () {
                        // Handle subscription action
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Color(0xffe3eed4), // Icon color changed
                      ),
                    ),
                  ],
                ),
              ),

              // Right side: All rights reserved text
              const Text(
                "© 2024, 3N1. All rights reserved.",
                style: TextStyle(
                  color: Color(0xff0c1f25), // Text color changed to dark color
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}