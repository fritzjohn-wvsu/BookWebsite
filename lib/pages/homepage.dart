import 'package:flutter/material.dart';

void main() {
  runApp(const Homepage());
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Navigation Bar (Row)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Left side content: Logo and LITFinds text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'icon.png',
                        width: 100,
                        height: 100,
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

                  // Middle content: Home, About, Books
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Home',
                          style:
                              TextStyle(color: Color(0xffe3eed4), fontSize: 15),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'About',
                          style:
                              TextStyle(color: Color(0xffe3eed4), fontSize: 15),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Books',
                          style:
                              TextStyle(color: Color(0xffe3eed4), fontSize: 15),
                        ),
                      ),
                    ],
                  ),

                  // Right side content: Search bar and user icon
                  Row(
                    children: [
                      // Search bar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: 250,
                        height: 40,
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.search,
                                color: Color.fromARGB(255, 0, 15, 22),
                                size: 18,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 0, 15, 22),
                                    fontSize: 15,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                ),
                              ),
                            ),
                          ],
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

              // Space between navigation bar and body description
              const SizedBox(height: 100),

              // Body Description Section with Padding
              Padding(
                padding: const EdgeInsets.only(left: 50), // Padding on left
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main heading
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
                        padding: EdgeInsets
                            .zero, // Remove default padding from the button itself
                      ),
                      child: Container(
                        width: 200, // Set the fixed width for the button
                        height: 50, // Set the fixed height for the button
                        padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10), // Padding inside the button
                        decoration: BoxDecoration(
                          color: const Color(
                              0xffe3eed4), // Background color of the button
                          // No borderRadius for sharp, rectangular corners
                        ),
                        child: const Center(
                          // Ensure the text is centered inside the button
                          child: Text(
                            'Start Now',
                            style: TextStyle(
                              color:
                                  Color.fromARGB(255, 0, 15, 22), // Text color
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // New Page Container Section (Adding a new section)
              const SizedBox(height: 200), // Space between sections

              // New Container for New Page
              Center(
                child: Container(
                  width: 1450,
                  height:
                      700, // Set the width of the new container to match the button
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 15,
                        22), // Background color for new page section
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Popular Today Title
                      const Text(
                        "Popular Today",
                        style: TextStyle(
                          fontSize: 30,
                          color: const Color(0xffe3eed4),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Divider line under the title
                      const Divider(
                        color: Color(0xffe3eed4), // Color of the line
                        thickness: 1, // Thickness of the line
                        height: 20, // Space between the text and the line
                      ),

                      // Row of small rectangles with text below
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Rectangle with text
                          Column(
                            children: [
                              Container(
                                width: 200,
                                height: 300,
                                color: const Color(0xffe3eed4),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Book 1',
                                style: TextStyle(
                                  color: Color(0xffe3eed4),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Row for number, star icon, and ongoing status
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Number of reviews or rating
                                  const Text(
                                    '10',
                                    style: TextStyle(
                                      color: Color(0xffe3eed4),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  // Star icon
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 100),
                                  // Ongoing status
                                  const Text(
                                    'Ongoing',
                                    style: TextStyle(
                                      color: Color(0xffe3eed4),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Rectangle with text
                          Column(
                            children: [
                              Container(
                                width: 200,
                                height: 300,
                                color: const Color(0xffe3eed4),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Book 2',
                                style: TextStyle(
                                  color: Color(0xffe3eed4),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          // Rectangle with text
                          Column(
                            children: [
                              Container(
                                width: 200,
                                height: 300,
                                color: const Color(0xffe3eed4),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Book 3',
                                style: TextStyle(
                                  color: Color(0xffe3eed4),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          // Rectangle with text
                          Column(
                            children: [
                              Container(
                                width: 200,
                                height: 300,
                                color: const Color(0xffe3eed4),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Book 4',
                                style: TextStyle(
                                  color: Color(0xffe3eed4),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          // Rectangle with text
                          Column(
                            children: [
                              Container(
                                width: 200,
                                height: 300,
                                color: const Color(0xffe3eed4),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Book 5',
                                style: TextStyle(
                                  color: Color(0xffe3eed4),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "This is the content for a new page. You can add more details here.",
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color(0xffe3eed4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
