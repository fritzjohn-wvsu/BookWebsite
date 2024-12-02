import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class BookDetailPage extends StatefulWidget {
  final String title;
  final String? imageUrl;
  final String description;
  final String author;
  final String publishedDate;
  final String categories;
  final String printType;
  final String previewLink; // Added preview link field

  const BookDetailPage({
    Key? key,
    required this.title,
    this.imageUrl,
    required this.description,
    required this.author,
    required this.publishedDate,
    required this.categories,
    required this.printType,
    required this.previewLink, // Added preview link parameter
  }) : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool _isExpanded = false;

  // Function to launch the URL
  Future<void> _launchURL() async {
    final Uri url = Uri.parse(widget.previewLink);
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch ${widget.previewLink}';
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
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20), // Adjusted padding to 20 for better spacing
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
                        width: 150, // Adjusted width for better fitting
                        height: 225, // Adjusted height for better fitting
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
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Adjusted spacing
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Description",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              widget.description,
                              style: const TextStyle(
                                color: Color(0xffe3eed4),
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify,
                              maxLines: _isExpanded ? null : 3,
                              overflow: _isExpanded
                                  ? TextOverflow.visible
                                  : TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15), // Adjusted spacing
                      // Author and Published Date Row side by side
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Author: ',
                              style: const TextStyle(
                                color: Color(0xffe3eed4),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              widget.author,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 30),
                            Text(
                              'Published: ',
                              style: const TextStyle(
                                color: Color(0xffe3eed4),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              widget.publishedDate,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Categories and Print Type Row side by side
                      Row(
                        children: [
                          Text(
                            'Categories: ',
                            style: const TextStyle(
                              color: Color(0xffe3eed4),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            widget.categories,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 30),
                          Text(
                            'Print Type: ',
                            style: const TextStyle(
                              color: Color(0xffe3eed4),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            widget.printType,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // Display Preview Link
                      SizedBox(height: 20), // Adjusted spacing
                      const Text(
                        'Preview Link: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      GestureDetector(
                        onTap: _launchURL, // Make the link clickable
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}