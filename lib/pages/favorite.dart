import 'package:flutter/material.dart';
import 'bookDetails.dart'; // Ensure this matches your file structure
import 'navigation.dart'; // Import your Navbar widget here

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
      body: Column(
        children: [
          // Your custom Navbar
          navigationBar(context),
          
          Expanded(
            child: ListView.builder(
              itemCount: BookDetailPage.favoriteBooks.length,
              itemBuilder: (context, index) {
                final book = BookDetailPage.favoriteBooks[index];

                return ListTile(
                  leading: book['imageUrl'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            book['imageUrl'],
                            width: 50,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.book,
                          size: 50,
                          color: Colors.grey,
                        ),
                  title: Text(
                    book['title'] ?? 'No Title',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    book['author'] ?? 'Unknown Author',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onTap: () {
                    // Navigate to Book Detail Page with full details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailPage(
                          title: book['title'] ?? 'No Title',
                          imageUrl: book['imageUrl'],
                          description: book['description'] ?? 'No Description',
                          author: book['author'] ?? 'Unknown Author',
                          publishedDate: book['publishedDate'] ?? 'Unknown',
                          categories: book['categories'] ?? 'Unknown',
                          printType: book['printType'] ?? 'Unknown',
                          previewLink: book['previewLink'] ?? '',
                        ),
                      ),
                    ).then((_) {
                      // Refresh the favorites list when returning to this page
                      setState(() {});
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
