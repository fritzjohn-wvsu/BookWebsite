import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'bookDetails.dart'; // Import BookDetailPage
import 'navigation.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  // Fetch favorite books from Firestore
  Future<List<Map<String, dynamic>>> _fetchFavorites() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('favorites').get();
    return querySnapshot.docs
        .map((doc) =>
            {...doc.data(), 'id': doc.id}) // Add document ID to the data
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
      body: Column(
        children: [
          // Your custom Navbar (you can replace this with your actual navigation bar widget)
          navigationBar(context),

          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchFavorites(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Favorites Yet!'));
                }

                final favoriteBooks = snapshot.data!;

                return ListView.builder(
                  itemCount: favoriteBooks.length,
                  itemBuilder: (context, index) {
                    final book = favoriteBooks[index];

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
                              bookId: book['id'], // Pass the book ID
                              title: book['title'] ?? 'No Title',
                              imageUrl: book['imageUrl'] ?? '',
                              description:
                                  book['description'] ?? 'No Description',
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
