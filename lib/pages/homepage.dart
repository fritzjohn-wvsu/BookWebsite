import 'package:flutter/material.dart';

void main() {
  runApp(const Homepage());
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image
          Positioned.fill(
            child: Image.asset(
              'LitFinds.png',
              fit: BoxFit.cover, // Make the image cover the entire screen
            ),
          ),

          // Navigation bar (Row) on top of the image
          Padding(
            padding:
                const EdgeInsets.all(16.0), // Optional padding around the Row
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Left side content (Logo, LITFinds text)
                  Row(
                    children: [
                      Image.asset(
                        'icon.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'LITFinds',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "TanMerigue",
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Middle content (Home, About, Books)
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          // Handle "Home" navigation
                        },
                        child: Text(
                          'Home',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle "About" navigation
                        },
                        child: Text(
                          'About',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Books',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),

                  // Right side content (Search bar and user icon)
                  Row(
                    children: [
                      // Search bar
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(30), // Rounded corners
                        ),
                        width: 250,
                        height: 30, // Set a width for the search bar
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                              ), // Space between icon and TextField
                              child: Icon(
                                Icons.search, // Search icon
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(
                                    color:
                                        Colors.grey.shade600, // Hint text color
                                    fontSize: 13, // Resize the hint text
                                  ),
                                  border: InputBorder
                                      .none, // No border for the text field itself
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                          12), // Adjust height of the TextField
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // User icon
                      Container(
                        padding:
                            EdgeInsets.all(8), // Add padding inside the circle
                        decoration: BoxDecoration(
                          color:
                              Colors.black, // Set the circle's background color
                          shape: BoxShape.circle, // This makes it circular
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white, // Icon color
                          size: 30, // Icon size
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
