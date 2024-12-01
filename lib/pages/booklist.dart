import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:platform_proxy/platform_proxy.dart';
import 'navigation.dart'; // Import the navigation bar file

class BookList extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookList> {
  List<dynamic> books = [];

  @override
  void initState() {
    
    super.initState();
    fetchBooks();
  }

  // Fetch book data from the Google Books API
  Future<void> fetchBooks() async {
    final url =
        'https://www.googleapis.com/books/v1/volumes?q=flutter&key=AIzaSyBKsd3N8K0L4d6I-UZf5sOQE5LHWvdyPbk'; // Replace with your API key
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          books = data['items'] ?? [];
        });
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching books: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          navigationBar(context),
          Expanded(
            child: books.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 15, 22),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Book List",
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xffe3eed4),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(
                            color: Color(0xffe3eed4),
                            thickness: 1,
                            height: 20,
                          ),
                          const SizedBox(height: 25),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: books.map((book) {
                              final title = book['volumeInfo']['title'] ?? "No Title";
                              final imageLinks = book['volumeInfo']['imageLinks'];
                              final imageUrl = imageLinks != null ? imageLinks['thumbnail'] : null;
                              return _bookRectangle(title, imageUrl);
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

  Widget _bookRectangle(String bookTitle, String? imageUrl) {
  final secureImageUrl = imageUrl?.replaceFirst('http:', 'https:');
  
  return Column(
    children: [
      Container(
        width: 150,
        height: 200,
        color: const Color(0xffe3eed4),
        child: secureImageUrl != null
            ? Image.network(
                secureImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 100,
                    color: Colors.grey,
                  );
                },
              )
            : const Icon(
                Icons.broken_image,
                size: 100,
                color: Colors.grey,
              ),
      ),
      const SizedBox(height: 10),
      Text(
        bookTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xffe3eed4),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}
}