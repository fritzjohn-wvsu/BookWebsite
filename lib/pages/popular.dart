import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'bookDetails.dart';

// Your Google Books API key
const String googleBooksApiKey = 'AIzaSyDlMTirZpmVZ5h_8O3LJuwiThVYhickyIw';

Future<List<dynamic>> fetchBooks() async {
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

    // Fetch the books
    List<dynamic> allBooks = [];

    for (var response in responses) {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['items'] ?? [];
        allBooks.addAll(items);
      } else {
        debugPrint('Error fetching books: ${response.statusCode}');
      }
    }

    allBooks.shuffle(Random());

    return allBooks.take(5).toList();
  } catch (e) {
    debugPrint('Error fetching books: $e');
    return [];
  }
}

Widget popularBook() {
  return FutureBuilder<List<dynamic>>(
    future: fetchBooks(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No books found.'));
      } else {
        final books = snapshot.data!;

        return Center(
          child: SingleChildScrollView(
            child: Container(
              width: 1450,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 15, 22),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Popular Today",
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
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 200 / 300,
                    ),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      final volumeInfo = book['volumeInfo'];
                      final title = volumeInfo['title'] ?? 'Unknown Title';
                      final imageUrl = volumeInfo['imageLinks']?['thumbnail'];
                      final description = volumeInfo['description'] ??
                          'No description available';
                      final author = volumeInfo['authors'] != null &&
                              volumeInfo['authors'].isNotEmpty
                          ? volumeInfo['authors'][0]
                          : 'Unknown Author';
                      final publishedDate =
                          volumeInfo['publishedDate'] ?? 'Unknown Date';
                      final categories = volumeInfo['categories'] != null &&
                              volumeInfo['categories'].isNotEmpty
                          ? volumeInfo['categories'].join(', ')
                          : 'No categories available';
                      final printType = volumeInfo['printType'] ?? 'Unknown';
                      final previewLink = volumeInfo['previewLink'] ?? '';

                      return GestureDetector(
                        onTap: () {
                          if (imageUrl != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetailPage(
                                  title: title,
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
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetailPage(
                                  title: title,
                                  imageUrl: 'no_image',
                                  description: description,
                                  author: author,
                                  publishedDate: publishedDate,
                                  categories: categories,
                                  printType: printType,
                                  previewLink: previewLink,
                                ),
                              ),
                            );
                          }
                        },
                        child: Column(
                          children: [
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
                              child: imageUrl == null
                                  ? const Center(
                                      child: Text(
                                        'No Image Found',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 200,
                              child: Text(
                                title,
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
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }
    },
  );
}
