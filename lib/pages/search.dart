import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'bookDetails.dart';
import 'navigation.dart';

class SearchPage extends StatefulWidget {
  final String query;

  const SearchPage({super.key, required this.query});

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
    searchController.text = widget.query;
    fetchBooks(widget.query);
  }

//fetch the books
  Future<void> fetchBooks(String query) async {
    final url = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$query&key=AIzaSyDlMTirZpmVZ5h_8O3LJuwiThVYhickyIw');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        books = data['items'] ?? [];
        showDropdown = books.isNotEmpty;
      });
    } else {
      print('Failed to fetch books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
      body: Stack(
        children: [
          if (showDropdown)
            Positioned.fill(
              child: Material(
                color: const Color.fromARGB(255, 0, 15, 22),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Search result for "${searchController.text}"',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          final book = books[index]['volumeInfo'];
                          return Padding(
                            padding: EdgeInsets.only(
                              top: index == 0 ? 20.0 : 8.0,
                              left: 8.0,
                              right: 8.0,
                              bottom: 8.0,
                            ),
                            child: ListTile(
                              leading: book['imageLinks']?['thumbnail'] != null
                                  ? Image.network(
                                      book['imageLinks']['thumbnail'],
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                    )
                                  : Container(
                                      width: 50,
                                      height: 50,
                                      color: Colors.grey,
                                      child: const Icon(
                                        Icons.book,
                                        color: Colors.white,
                                      ),
                                    ),
                              title: Text(
                                book['title'] ?? 'No Title',
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                book['authors']?.join(', ') ?? 'Unknown Author',
                                style: const TextStyle(color: Colors.white70),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    //go to bookdetailpage
                                    builder: (context) => BookDetailPage(
                                      bookId: book['id'] ??
                                          'Unknown ID', // Pass the book ID
                                      title: book['title'] ?? 'No Title',
                                      imageUrl: book['imageLinks']
                                          ?['thumbnail'],
                                      description: book['description'] ??
                                          'No Description',
                                      author: book['authors']?.join(', ') ??
                                          'Unknown Author',
                                      publishedDate:
                                          book['publishedDate'] ?? 'Unknown',
                                      categories:
                                          book['categories']?.join(', ') ??
                                              'Unknown',
                                      printType: book['printType'] ?? 'Unknown',
                                      previewLink: book['previewLink'] ??
                                          'https://www.google.com',
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 15, 22),
                          backgroundColor: const Color(0xffe3eed4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: navigationBar(context),
          ),
        ],
      ),
    );
  }
}
