import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'bookDetails.dart';
import 'navigation.dart';

// Google Books API Key
const String googleBooksApiKey = 'AIzaSyDlMTirZpmVZ5h_8O3LJuwiThVYhickyIw';

class BookListWidget extends StatefulWidget {
  const BookListWidget({super.key});

  @override
  _BookListWidgetState createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {
  List<dynamic> allBooks = [];
  List<dynamic> filteredBooks = [];
  bool isLoading = true;
  String _selectedSort = 'A-Z';
  String _selectedGenre = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> availableGenres = [
    'All',
    'Fiction',
    'Fantasy',
    'Action',
    'Poetry',
    'Art',
    'Education',
    'History',
    'Law',
    'Nature',
    'Photography',
    'Psychology',
    'Mathematics',
    'Cooking',
    'Travel',
  ];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final genresToFetch = _selectedGenre == 'All'
          ? availableGenres.sublist(1)
          : [_selectedGenre];

      final responses = await Future.wait(genresToFetch.map((genre) {
        final url =
            'https://www.googleapis.com/books/v1/volumes?q=subject:$genre&maxResults=5&key=$googleBooksApiKey';
        return http.get(Uri.parse(url));
      }));

      List<dynamic> books = [];
      for (var response in responses) {
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          books.addAll(data['items'] ?? []);
        } else {
          debugPrint('Error fetching books for genre: ${response.statusCode}');
        }
      }

      setState(() {
        allBooks = books;
        filteredBooks = books;
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

  void sortBooks() {
    filteredBooks.sort((a, b) {
      final titleA = a['volumeInfo']['title'] ?? '';
      final titleB = b['volumeInfo']['title'] ?? '';
      if (_selectedSort == 'A-Z') return titleA.compareTo(titleB);
      if (_selectedSort == 'Z-A') return titleB.compareTo(titleA);
      final dateA = DateTime.tryParse(a['volumeInfo']['publishedDate'] ?? '') ??
          DateTime(1900);
      final dateB = DateTime.tryParse(b['volumeInfo']['publishedDate'] ?? '') ??
          DateTime(1900);
      if (_selectedSort == 'Newest') return dateB.compareTo(dateA);
      if (_selectedSort == 'Oldest') return dateA.compareTo(dateB);
      return 0;
    });
    setState(() {});
  }

  void filterBooks(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredBooks = allBooks;
      } else {
        filteredBooks = allBooks.where((book) {
          final title = book['volumeInfo']['title']?.toLowerCase() ?? '';
          final author =
              book['volumeInfo']['authors']?.join(', ')?.toLowerCase() ?? '';
          return title.contains(query.toLowerCase()) ||
              author.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  Widget _bookCard(Map<String, dynamic> book) {
    final volumeInfo = book['volumeInfo'];
    final title = volumeInfo['title'] ?? 'Unknown Title';
    final imageUrl = volumeInfo['imageLinks']?['thumbnail'];
    final author = (volumeInfo['authors']?.isNotEmpty ?? false)
        ? volumeInfo['authors'][0]
        : 'Unknown Author';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(
              bookId: book['id'] ?? 'Unknown ID',
              title: title,
              imageUrl: imageUrl,
              description: volumeInfo['description'] ?? 'No description',
              author: author,
              publishedDate: volumeInfo['publishedDate'] ?? 'Unknown Date',
              categories: (volumeInfo['categories']?.join(', ') ?? 'Unknown'),
              printType: volumeInfo['printType'] ?? 'Unknown',
              previewLink: volumeInfo['previewLink'] ?? '',
            ),
          ),
        );
      },
      child: Column(
        children: [
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
            child: imageUrl == null
                ? Center(child: Icon(Icons.book, color: Colors.white, size: 60))
                : null,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xffe3eed4),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 200 / 300,
      ),
      itemCount: filteredBooks.length,
      itemBuilder: (context, index) {
        return _bookCard(filteredBooks[index]);
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
                      padding: const EdgeInsets.all(40.0),
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
                          ),
                          const SizedBox(height: 20),
                          // Search Bar
                          TextField(
                            controller: _searchController,
                            onChanged: (query) {
                              filterBooks(query);
                            },
                            decoration: InputDecoration(
                              labelText: 'Search Books',
                              labelStyle:
                                  const TextStyle(color: Color(0xffe3eed4)),
                              hintText: 'Enter book name or author',
                              hintStyle:
                                  const TextStyle(color: Color(0xffe3eed4)),
                              filled: true,
                              fillColor: const Color(0xff293d3e),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(11, 11, 11,
                                        1)), // Set border color to white
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                    color: Colors
                                        .black), // Border color when the field is enabled
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                    color: Colors
                                        .white), // Border color when the field is focused
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Combined Row for Genre and Sort Dropdowns, Centered
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Sort Dropdown (now first)
                                Container(
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff293d3e),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14.0),
                                    child: DropdownButton<String>(
                                      value: _selectedSort,
                                      items: ['A-Z', 'Z-A', 'Newest', 'Oldest']
                                          .map((sortOption) => DropdownMenuItem(
                                                value: sortOption,
                                                child: Text(
                                                  sortOption,
                                                  style: const TextStyle(
                                                      color: Color(0xffe3eed4)),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedSort = value!;
                                          sortBooks(); // Re-sort the books when a new option is selected
                                        });
                                      },
                                      dropdownColor: const Color(0xff1c2a36),
                                      style: const TextStyle(
                                          color: Color(0xffe3eed4)),
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Color(0xffe3eed4),
                                      ),
                                      isExpanded: true,
                                      underline: Container(
                                        height: 1,
                                        color: const Color(0xff293d3e),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 50),
                                // Genre Dropdown (now second)
                                Container(
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff293d3e),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14.0),
                                    child: DropdownButton<String>(
                                      value: _selectedGenre,
                                      dropdownColor: const Color(0xff293d3e),
                                      borderRadius: BorderRadius.circular(24),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedGenre = newValue!;
                                          fetchBooks();
                                        });
                                      },
                                      items: availableGenres
                                          .map<DropdownMenuItem<String>>(
                                        (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: const TextStyle(
                                                  color: Color(0xffe3eed4)),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Color(0xffe3eed4),
                                      ),
                                      isExpanded: true,
                                      underline: Container(
                                        height: 1,
                                        color: const Color(0xff293d3e),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildBookGrid(),
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
