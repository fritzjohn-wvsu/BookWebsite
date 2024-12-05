import 'package:flutter/material.dart';
import 'bookDetails.dart'; // Import BookDetailPage for navigation

class FavoriteBooksPage extends StatelessWidget {
  const FavoriteBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 15, 22),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xffe3eed4), // Color of the back arrow
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Favorites',
          style: TextStyle(
            color: Color(0xffe3eed4), // Color of the title
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: BookDetailPage.favoriteBooks.length,
        itemBuilder: (context, index) {
          var book = BookDetailPage.favoriteBooks[index];
          return Card(
            color: const Color(0xff1b2a38),
            child: ListTile(
              leading: book['imageUrl'] != null
                  ? Image.network(book['imageUrl'],
                      width: 50, height: 75, fit: BoxFit.cover)
                  : const SizedBox(width: 50, height: 75),
              title: Text(
                book['title'],
                style: const TextStyle(color: Color(0xffe3eed4)),
              ),
              subtitle: Text(
                book['author'],
                style: const TextStyle(color: Colors.white70),
              ),
              onTap: () {
                // Navigate to BookDetailPage with book details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(
                      title: book['title'],
                      imageUrl: book['imageUrl'],
                      description: book['description'],
                      author: book['author'],
                      publishedDate: book['publishedDate'],
                      categories: book['categories'],
                      printType: book['printType'],
                      previewLink: book['previewLink'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
