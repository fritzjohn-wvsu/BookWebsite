import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'navigation.dart'; // Assuming this is a custom widget
import 'bookDetails.dart'; // Assuming this is the BookDetailPage

// Your Google Books API key
const String googleBooksApiKey = 'AIzaSyBKsd3N8K0L4d6I-UZf5sOQE5LHWvdyPbk';

class BookListWidget extends StatefulWidget {
  @override
  _BookListWidgetState createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {
  List<dynamic> allBooks = [];
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

      if (!mounted) return;

      setState(() {
        allBooks = [];

        for (var response in responses) {
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            final items = data['items'] ?? [];

            for (var item in items) {
              allBooks.add(item);
            }
          } else {
            debugPrint('Error fetching books: ${response.statusCode}');
          }
        }

        // Initially sort the books by title A-Z after fetching
        sortBooksAtoZ();
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

  // A-Z sorting by book title
  void sortBooksAtoZ() {
    allBooks.sort((a, b) {
      final titleA = a['volumeInfo']['title'] ?? '';
      final titleB = b['volumeInfo']['title'] ?? '';
      return titleA.compareTo(titleB); // A-Z sorting by title
    });
    setState(() {
      // Refresh the UI after sorting
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
                          // A-Z Sort Button
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: sortBooksAtoZ,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 30.0),
                                ),
                                child: const Text(
                                  'Sort A-Z',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          _buildBookGrid(allBooks), // Display sorted books
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
