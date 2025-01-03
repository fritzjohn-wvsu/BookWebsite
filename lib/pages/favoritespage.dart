import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bookDetails.dart';

class FavoriteBooksPage extends StatefulWidget {
  const FavoriteBooksPage({Key? key}) : super(key: key);

  @override
  _FavoriteBooksPageState createState() => _FavoriteBooksPageState();
}

class _FavoriteBooksPageState extends State<FavoriteBooksPage> {
  List<Map<String, dynamic>> favoriteBooks = [];
  final String? userEmail = FirebaseAuth.instance.currentUser?.email;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (userEmail != null) {
      _fetchFavoriteBooks();
    }
  }

  Future<void> _fetchFavoriteBooks() async {
    if (userEmail == null) return;

    try {
      final collection = FirebaseFirestore.instance.collection('favorites');
      final querySnapshot =
          await collection.where('email', isEqualTo: userEmail).get();

      if (querySnapshot.docs.isEmpty) {
        print('No favorite books found.');
      }

      setState(() {
        favoriteBooks = querySnapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'title': (data['title'] ?? 'Unknown Title').toString(),
            'imageUrl': (data['imageUrl'] ?? '').toString(),
            'description':
                (data['description'] ?? 'No description available.').toString(),
            'author': (data['author'] ?? 'Unknown Author').toString(),
            'publishedDate':
                (data['publishedDate'] ?? 'Unknown Date').toString(),
            'categories':
                (data['categories'] ?? 'Unknown Categories').toString(),
            'printType': (data['printType'] ?? 'Unknown Print Type').toString(),
            'previewLink': (data['previewLink'] ?? '').toString(),
            'docId': doc.id,
          };
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching favorite books: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Remove a book from favorites
  Future<void> _removeFromFavorites(String docId) async {
    if (userEmail == null) return;

    try {
      final collection = FirebaseFirestore.instance.collection('favorites');
      await collection.doc(docId).delete();
      _fetchFavoriteBooks();
    } catch (e) {
      print('Error removing favorite book: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 15, 22),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xffe3eed4),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Color(0xffe3eed4),
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xffe3eed4),
              ),
            )
          : favoriteBooks.isEmpty
              ? const Center(
                  child: Text(
                    'No favorite books added yet.',
                    style: TextStyle(color: Color(0xffe3eed4), fontSize: 16),
                  ),
                )
              : SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 15, 22),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Your Favorites",
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
                            SizedBox(
                              height: 600,
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: 200 / 300,
                                ),
                                itemCount: favoriteBooks.length,
                                itemBuilder: (context, index) {
                                  var book = favoriteBooks[index];

                                  return GestureDetector(
                                    onTap: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookDetailPage(
                                            title: book['title'] ??
                                                'Unknown Title',
                                            imageUrl: book['imageUrl'] ?? '',
                                            description: book['description'] ??
                                                'No description available.',
                                            author: book['author'] ??
                                                'Unknown Author',
                                            publishedDate:
                                                book['publishedDate'] ??
                                                    'Unknown Date',
                                            categories: book['categories'] ??
                                                'Unknown Categories',
                                            printType: book['printType'] ??
                                                'Unknown Print Type',
                                            previewLink:
                                                book['previewLink'] ?? '',
                                          ),
                                        ),
                                      );

                                      if (result != null) {
                                        _fetchFavoriteBooks();
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 200,
                                          height: 300,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffe3eed4),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: book['imageUrl'] != null
                                                ? DecorationImage(
                                                    image: NetworkImage(
                                                        book['imageUrl']!),
                                                    fit: BoxFit.cover,
                                                  )
                                                : null,
                                          ),
                                          child: book['imageUrl'] == null
                                              ? const Center(
                                                  child: Icon(Icons.book,
                                                      size: 60),
                                                )
                                              : null,
                                        ),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            book['title'] ?? 'Unknown Title',
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
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          width: 200,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Color(0xffe3eed4),
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              _removeFromFavorites(
                                                  book['docId']);
                                            },
                                            child: const Text(
                                              'Remove',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
