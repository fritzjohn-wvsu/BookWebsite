import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'bookDetails.dart'; 

// Google Books API key
const String googleBooksApiKey = 'AIzaSyDoVXygeRZe-s07DSFWQFcO5ITv1juwN34';

Future<List<dynamic>> fetchBooks() async {
  final urls = [
    'https://www.googleapis.com/books/v1/volumes?q=fiction&key=$googleBooksApiKey',
    'https://www.googleapis.com/books/v1/volumes?q=non+fiction&key=$googleBooksApiKey',
  ];

  List<dynamic> allBooks = [];

  try {
    final responses = await Future.wait(
      urls.map((url) async {
        final response = await http.get(Uri.parse(url));
        return response;
      }),
    );

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

    // Sort books by the publication date in descending order
    allBooks.sort((a, b) {
      final dateA = a['volumeInfo']['publishedDate'] ?? '';
      final dateB = b['volumeInfo']['publishedDate'] ?? '';
      return dateB.compareTo(dateA); // Descending order by date
    });

    // Limit to only the 10 latest books
    return allBooks.take(10).toList();
  } catch (e) {
    debugPrint('Error fetching books: $e');
    return [];
  }
}

Widget bookRectangle(
    BuildContext context, // Accept context here
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
        context, // Use the passed context
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
        // Publication Date on a new line
        SizedBox(
          width: 200,
          child: Text(
            '($publishedDate)', // Date in parentheses
            style: const TextStyle(
              color: Color(0xffe3eed4),
              fontSize: 12,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget buildBookGrid(List<dynamic> bookList, BuildContext context) {  // Pass context here
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

      return bookRectangle(
        context,  // Pass context here
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

Widget updateList(BuildContext context) {
  return FutureBuilder<List<dynamic>>(
    future: fetchBooks(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return const Center(child: Text('Error fetching books'));
      }

      final books = snapshot.data ?? [];

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Latest Updates",
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
              buildBookGrid(books, context), // Pass context to buildBookGrid
            ],
          ),
        ),
      );
    },
  );
}
