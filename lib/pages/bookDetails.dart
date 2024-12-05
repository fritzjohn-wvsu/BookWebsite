import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailPage extends StatefulWidget {
  final String bookId;
  final String title;
  final String imageUrl;
  final String description;
  final String author;
  final String publishedDate;
  final String categories;
  final String printType;
  final String previewLink;

  const BookDetailPage({
    super.key,
    required this.bookId,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.author,
    required this.publishedDate,
    required this.categories,
    required this.printType,
    required this.previewLink,
  });

  static List<Map<String, dynamic>> favoriteBooks = [];

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool _isExpanded = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = BookDetailPage.favoriteBooks
        .any((book) => book['title'] == widget.title);
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorite) {
        BookDetailPage.favoriteBooks
            .removeWhere((book) => book['title'] == widget.title);
      } else {
        BookDetailPage.favoriteBooks.add({
          'title': widget.title,
          'imageUrl': widget.imageUrl,
          'description': widget.description,
          'author': widget.author,
          'publishedDate': widget.publishedDate,
          'categories': widget.categories,
          'printType': widget.printType,
          'previewLink': widget.previewLink,
        });
      }
      _isFavorite = !_isFavorite;
    });
  }

  Future<void> _launchPreviewLink() async {
    if (await canLaunch(widget.previewLink)) {
      await launch(widget.previewLink);
    } else {
      throw 'Could not open preview link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
      appBar: AppBar(
        title: const Text(
          'Book Details',
          style: TextStyle(color: Color(0xffe3eed4)),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 15, 22),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(100),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align the content properly
          children: [
            // Left side: Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: Colors.white,
                child: Image.network(
                  widget.imageUrl,
                  width: 200,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 30),

            // Right side: Book Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _isFavorite ? Colors.red : Colors.white,
                          ),
                          onPressed: _toggleFavorite,
                        ),
                        Text(
                          _isFavorite
                              ? "Added to Favorites"
                              : "Add to Favorites",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),

                  // Description above the author, published, genre, and print type
                  const SizedBox(height: 20),
                  const Text(
                    "Synopsis",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    maxLines: _isExpanded ? null : 3,
                    overflow: _isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Text(
                        _isExpanded ? "Show Less" : "Show More",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Author and Published Date in one row
                  Row(
                    children: [
                      Text(
                        'Author: ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.author,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold, // Make the author bold
                        ),
                      ),
                      const SizedBox(width: 30),
                      Text(
                        'Published: ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.publishedDate,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight:
                              FontWeight.bold, // Make the published date bold
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Genre and Print Type in one row
                  Row(
                    children: [
                      Text(
                        'Genre: ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.categories,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold, // Make the genre bold
                        ),
                      ),
                      const SizedBox(width: 30),
                      Text(
                        'Print Type: ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.printType,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight:
                              FontWeight.bold, // Make the print type bold
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Preview Link
                  const Text(
                    'Preview Link:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: _launchPreviewLink,
                    child: Text(
                      widget.previewLink,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
