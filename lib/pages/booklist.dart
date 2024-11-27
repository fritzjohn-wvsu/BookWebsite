import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'navigation.dart'; // Import the navigation bar file

class BookList extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookList> {
  List<dynamic> books = []; // Updated from 'meals' to 'books'

  @override
  void initState() {
    super.initState();
    fetchBooks(); // Fetch books when the page is initialized
  }

  // Fetch book data from the Google Books API
  Future<void> fetchBooks() async {
    final url =
        'https://www.googleapis.com/books/v1/volumes?q=romance&key=AIzaSyBKsd3N8K0L4d6I-UZf5sOQE5LHWvdyPbk'; // API link
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        books = data['items'] ?? []; // Use the 'items' array from the API
      });
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          navigationBar(context), // Call the navigationBar widget here
          Expanded(
            child: books.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  ) // Show loading indicator
                : SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 15,
                            22), // Set the container background color
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Book List",
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xffe3eed4), // Light text color
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(
                            color: Color(0xffe3eed4),
                            thickness: 1,
                            height: 20,
                          ),
                          const SizedBox(height: 25),
                          // Generate rows of books
                          Column(
                            children: books.map((book) {
                              final volumeInfo = book['volumeInfo'];
                              final title = volumeInfo['title'] ?? 'No Title';
                              final description =
                                  volumeInfo['description'] ?? 'No Description';
                              final thumbnail = volumeInfo['imageLinks']
                                      ?['thumbnail'] ??
                                  ''; // Thumbnail URL
                              return _bookRectangle(
                                  title, thumbnail, description);
                            }).toList(),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Helper widget to create a rectangle for each book
  Widget _bookRectangle(String title, String imageUrl, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200,
          height: 300,
          color: const Color(0xffe3eed4), // Light color for the container
          child: imageUrl.isNotEmpty
              ? Image.network(imageUrl, fit: BoxFit.cover)
              : const Icon(Icons.book,
                  size: 100, color: Colors.grey), // Default icon if no image
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xffe3eed4), // Text color
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xffe3eed4), // Text color
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
