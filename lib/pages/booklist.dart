import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'bookDetails.dart'; // Assuming this is the BookDetailPage
import 'navigation.dart'; // Assuming this is a custom widget for navigation

// Your Google Books API key
const String googleBooksApiKey = 'AIzaSyAOtxByjKg7p_pTnR8ZWk5e88Wh4ROMP7Q';

class BookListWidget extends StatefulWidget {
  @override
  _BookListWidgetState createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {
  List<dynamic> allBooks = []; // To store books from all genres
  List<dynamic> filteredBooks = []; // Books filtered by search
  bool isLoading = true;
  String _selectedSort = 'A-Z'; // Default sort option
  String _selectedGenre = 'All'; // Default genre (All books)
  TextEditingController _searchController = TextEditingController();

  // Genres to filter by
  final List<String> availableGenres = [
    'All', // Option to show all genres
    'Fiction',
    'Non-Fiction',
    'Fantasy',
    'Action'
  ];

  @override
  void initState() {
    super.initState();
    fetchBooks(); // Fetch all books initially
  }

  // Fetch books for all genres concurrently
  Future<void> fetchBooks() async {
    try {
      final genres = ['Fiction', 'Non-Fiction', 'Fantasy', 'Action'];

      // Creating a list of Future requests for each genre
      final List<Future<http.Response>> requests = genres.map((genre) {
        final url =
            'https://www.googleapis.com/books/v1/volumes?q=subject:$genre&maxResults=5&key=$googleBooksApiKey';
        return http.get(Uri.parse(url));
      }).toList();

      // Wait for all requests to complete
      final responses = await Future.wait(requests);

      // Collect all books from the responses
      List<dynamic> books = [];
      for (var response in responses) {
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          books.addAll(data['items'] ?? []); // Add books to the list
        } else {
          debugPrint('Error fetching books: ${response.statusCode}');
        }
      }

      setState(() {
        allBooks = books; // Store the fetched books
        filteredBooks = books; // Set the initial filtered books to all books
        // Apply sorting after books are fetched
        sortBooks();

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching books: $e');
    }
  }

  // Sorting logic based on selected dropdown option (A-Z or Z-A)
  void sortBooks() {
    if (_selectedSort == 'A-Z') {
      // Sort books alphabetically by title (A-Z)
      filteredBooks.sort((a, b) {
        final titleA = a['volumeInfo']['title'] ?? '';
        final titleB = b['volumeInfo']['title'] ?? '';
        return titleA.compareTo(titleB); // A-Z sorting by title
      });
    } else if (_selectedSort == 'Z-A') {
      // Sort books in reverse alphabetical order (Z-A)
      filteredBooks.sort((a, b) {
        final titleA = a['volumeInfo']['title'] ?? '';
        final titleB = b['volumeInfo']['title'] ?? '';
        return titleB.compareTo(titleA); // Z-A sorting by title
      });
    }

    setState(() {}); // Rebuild UI after sorting
  }

  // Function to filter books based on the search query
  void filterBooks(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredBooks = allBooks; // Show all books if search is empty
      });
    } else {
      setState(() {
        filteredBooks = allBooks.where((book) {
          final title = book['volumeInfo']['title']?.toLowerCase() ?? '';
          final author =
              book['volumeInfo']['authors']?.join(', ')?.toLowerCase() ?? '';
          final searchQuery = query.toLowerCase();
          return title.contains(searchQuery) || author.contains(searchQuery);
        }).toList();
      });
    }
  }

  // Widget to display each book in a rectangular card
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

  // Widget to display books in a grid
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
                          // Search Bar with inset of 30
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextField(
                              controller: _searchController,
                              onChanged: filterBooks,
                              decoration: InputDecoration(
                                hintText: 'Search by title or author...',
                                hintStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Color(0xFF333333),
                                contentPadding: EdgeInsets.all(16),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 25),
                          // Sort Dropdowns in a Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // A-Z Sort Dropdown
                              Container(
                                width: 200,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 1), // White border
                                  borderRadius: BorderRadius.circular(
                                      8), // Rounded corners
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      8.0), // Add padding inside the container
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: 100),
                                    child: DropdownButton<String>(
                                      value: _selectedSort,
                                      isExpanded: true,
                                      items: ['A-Z', 'Z-A']
                                          .map((String value) =>
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedSort = newValue!;
                                        });
                                        sortBooks(); // Sort books after selecting option
                                      },
                                      style: TextStyle(color: Colors.white),
                                      dropdownColor: Color(0xFF333333),
                                      underline: Container(
                                        height: 1,
                                        color: const Color.fromARGB(255, 0, 15, 22),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 50),
                              // Genre Dropdown
                              Container(
                                width: 200,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 1), // White border
                                  borderRadius: BorderRadius.circular(
                                      8), // Rounded corners
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      8.0), // Add padding inside the container
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: 100),
                                    child: DropdownButton<String>(
                                      value: _selectedGenre,
                                      isExpanded: true,
                                      items: availableGenres
                                          .map((String genre) =>
                                              DropdownMenuItem<String>(
                                                value: genre,
                                                child: Text(
                                                  genre,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (newGenre) {
                                        setState(() {
                                          _selectedGenre = newGenre!;
                                          isLoading = true;
                                        });
                                        fetchBooks(); // Fetch books based on genre
                                      },
                                      style: TextStyle(color: Colors.white),
                                      dropdownColor: Color(0xFF333333),
                                      underline: Container(
                                        height: 1,
                                        color: const Color.fromARGB(255, 0, 15, 22),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          // Display books in grid format
                          _buildBookGrid(filteredBooks),
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
