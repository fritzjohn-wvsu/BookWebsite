import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'navigation.dart'; // Assuming this is a custom widget
import 'bookDetails.dart'; // Assuming this is the BookDetailPage

// Your Google Books API key
const String googleBooksApiKey = 'AIzaSyDlMTirZpmVZ5h_8O3LJuwiThVYhickyIw';

class BookListWidget extends StatefulWidget {
  @override
  _BookListWidgetState createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {
  List<dynamic> allBooks = [];
  List<dynamic> filteredBooks = [];
  String selectedGenre = 'All'; // Genre filter
  String selectedOrder = 'A-Z'; // Sorting order
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final urls = [
      'https://www.googleapis.com/books/v1/volumes?q=fiction&key=$googleBooksApiKey',
      'https://www.googleapis.com/books/v1/volumes?q=non+fiction&key=$googleBooksApiKey',
    ];

    try {
      final responses = await Future.wait(
        urls.map((url) async {
          final response = await http.get(Uri.parse(url));
          return response;
        }),
      );

      // Check if the widget is still mounted before updating the state
      if (!mounted) return;

      setState(() {
        // Combine the responses for both Fiction and Non-Fiction
        allBooks = [];
        for (var response in responses) {
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            allBooks.addAll(data['items'] ?? []);
          } else {
            debugPrint('Error fetching books: ${response.statusCode}');
          }
        }
        // Initially show all books
        filteredBooks = List.from(allBooks);
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching books: $e');
    }
  }

  // Function to filter books based on genre and order
  void filterBooks() {
    List<dynamic> filtered = allBooks;

    // Filter by genre
    if (selectedGenre != 'All') {
      filtered = filtered.where((book) {
        final categories = book['volumeInfo']['categories'] ?? [];
        return categories.contains(selectedGenre);
      }).toList();
    }

    // Sort the books based on the selected order
    if (selectedOrder == 'A-Z') {
      filtered.sort((a, b) =>
          a['volumeInfo']['title'].compareTo(b['volumeInfo']['title']));
    } else if (selectedOrder == 'Z-A') {
      filtered.sort((a, b) =>
          b['volumeInfo']['title'].compareTo(a['volumeInfo']['title']));
    }

    setState(() {
      filteredBooks = filtered;
    });
  }

  Widget _bookRectangle(
      String bookName,
      String? imageUrl,
      String description,
      String author,
      String publishedDate,
      String categories,
      String printType,
      String previewLink) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(
              title: bookName,
              imageUrl: imageUrl,
              description: description,
              author: author,
              publishedDate: publishedDate,
              categories: categories,
              printType: printType,
              previewLink: previewLink,
            ),
          ),
        );
      },
      child: Column(
        children: [
          // Book Image
          Container(
            width: 200,
            height: 300,
            decoration: BoxDecoration(
              color: const Color(0xffe3eed4),
              borderRadius: BorderRadius.circular(10),
              image: imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 8),
          // Book Title
          SizedBox(
            width: 200,
            child: Text(
              bookName,
              style: const TextStyle(
                color: Color(0xffe3eed4),
                fontSize: 14,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookGrid(List<dynamic> bookList) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, // 5 items per row
        crossAxisSpacing: 20.0, // Horizontal space
        mainAxisSpacing: 10.0, // Vertical space
        childAspectRatio: 200 / 300, // Width to height ratio
      ),
      itemCount: bookList.length,
      itemBuilder: (context, index) {
        final volumeInfo = bookList[index]['volumeInfo'];
        final title = volumeInfo['title'] ?? 'Unknown Title';
        final imageUrl = volumeInfo['imageLinks']?['thumbnail'];
        final description =
            volumeInfo['description'] ?? 'No description available';
        final author =
            volumeInfo['authors'] != null && volumeInfo['authors'].isNotEmpty
                ? volumeInfo['authors'][0]
                : 'Unknown Author';
        final publishedDate = volumeInfo['publishedDate'] ?? 'Unknown Date';
        final categories = volumeInfo['categories'] != null &&
                volumeInfo['categories'].isNotEmpty
            ? volumeInfo['categories'].join(', ')
            : 'No categories available';
        final printType = volumeInfo['printType'] ?? 'Unknown';
        final previewLink = volumeInfo['previewLink'] ?? '';

        return _bookRectangle(
          title,
          imageUrl,
          description,
          author,
          publishedDate,
          categories,
          printType,
          previewLink,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
      body: Column(
        children: [
          navigationBar(context),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
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
                          Row(
                            children: [
                              // Genre Dropdown
                              DropdownButton<String>(
                                value: selectedGenre,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedGenre = newValue!;
                                  });
                                  filterBooks();
                                },
                                items: ['All', 'Fiction', 'Non-Fiction']
                                    .map((genre) {
                                  return DropdownMenuItem<String>(
                                    value: genre,
                                    child: Text(genre),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(width: 20),
                              // Order Dropdown
                              DropdownButton<String>(
                                value: selectedOrder,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedOrder = newValue!;
                                  });
                                  filterBooks();
                                },
                                items: ['A-Z', 'Z-A'].map((order) {
                                  return DropdownMenuItem<String>(
                                    value: order,
                                    child: Text(order),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          _buildBookGrid(filteredBooks),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
