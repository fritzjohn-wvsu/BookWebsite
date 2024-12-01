import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'bookDetails.dart'; 
import 'navigation.dart'; 

class SearchPage extends StatefulWidget {
  final String query;

  const SearchPage({Key? key, required this.query}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> books = [];
  bool showDropdown = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.text = widget.query; // Initialize with the query passed in the constructor
    fetchBooks(widget.query); // Fetch books based on the initial query
  }

  Future<void> fetchBooks(String query) async {
    final url = Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        books = data['items'] ?? [];
        showDropdown = books.isNotEmpty; // Show dropdown if results exist
      });
    } else {
      print('Failed to fetch books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 15, 22), // Background set to black
      body: Stack(
        children: [
          // Dropdown positioned on the right side of the screen, below the navigation bar
          if (showDropdown)
            Positioned(
              top: kToolbarHeight + 20, // Added padding below the navigation bar
              right: 0,
              width: MediaQuery.of(context).size.width / 2, // Take half the screen width
              child: Material(
                color: Colors.transparent, // Make sure the background is transparent
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10), // Consistent padding inside the dropdown
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 2, // Limit height
                        child: Column(
                          children: [
                            // Text that says "Search result for [query]"
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Search result for "${searchController.text}"',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            // Results list
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: books.length,
                                itemBuilder: (context, index) {
                                  final book = books[index]['volumeInfo'];
                                  return ListTile(
                                    title: Text(
                                      book['title'] ?? 'No Title',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      book['authors']?.join(', ') ?? 'Unknown Author',
                                      style: const TextStyle(color: Colors.white70),
                                    ),
                                    onTap: () {
                                      // Navigate to BookDetailPage on tap
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookDetailPage(
                                            title: book['title'] ?? 'No Title',
                                            imageUrl: book['imageLinks']?['thumbnail'],
                                            description: book['description'] ?? 'No Description',
                                            author: book['authors']?.join(', ') ?? 'Unknown Author',
                                            publishedDate: book['publishedDate'] ?? 'Unknown',
                                            categories: book['categories']?.join(', ') ?? 'Unknown',
                                            printType: book['printType'] ?? 'Unknown',
                                            previewLink: book['previewLink'] ?? 'https://www.google.com',
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Include the navigation bar at the top of the screen
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: navigationBar(context), // Include your navigation bar widget
          ),
        ],
      ),
    );
  }
}
