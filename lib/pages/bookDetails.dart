import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'favoritespage.dart'; // Import the FavoriteBooksPage

class BookDetailPage extends StatefulWidget {
  final String title;
  final String? imageUrl;
  final String description;
  final String author;
  final String publishedDate;
  final String categories;
  final String printType;
  final String previewLink;

  const BookDetailPage({
    Key? key,
    required this.title,
    this.imageUrl,
    required this.description,
    required this.author,
    required this.publishedDate,
    required this.categories,
    required this.printType,
    required this.previewLink,
  }) : super(key: key);

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
        BookDetailPage.favoriteBooks.removeWhere((book) => book['title'] == widget.title);
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

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(widget.previewLink);
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch ${widget.previewLink}';
    }
  }

  // Navigation method to go to the FavoriteBooksPage
  void _navigateToFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FavoriteBooksPage()),
    );
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
        iconTheme: const IconThemeData(color: Color(0xffe3eed4)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.imageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      color: Colors.white,
                      child: Image.network(
                        widget.imageUrl!,
                        width: 200,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(width: 25),
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
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: _isFavorite ? Color(0xffe3eed4) : Color(0xffe3eed4),
                                  ),
                                  onPressed: _toggleFavorite,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Author: ${widget.author}',
                            style: const TextStyle(
                              color: Color(0xffe3eed4),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 30),
                          Text(
                            'Published: ${widget.publishedDate}',
                            style: const TextStyle(
                              color: Color(0xffe3eed4),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            'Genre: ${widget.categories}',
                            style: const TextStyle(
                              color: Color(0xffe3eed4),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 30),
                          Text(
                            'Print Type: ${widget.printType}',
                            style: const TextStyle(
                              color: Color(0xffe3eed4),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                color: Color(0xffe3eed4),
                fontSize: 16,
              ),
              maxLines: _isExpanded ? null : 3,
              overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(
                _isExpanded ? "Show Less" : "Show More",
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Preview Link:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            GestureDetector(
              onTap: _launchURL,
              child: Text(
                widget.previewLink,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
