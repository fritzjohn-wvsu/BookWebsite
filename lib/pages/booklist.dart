import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'bookDetails.dart'; // Assuming this is the BookDetailPage
import 'navigation.dart'; // Assuming this is a custom widget for navigation

// Your Google Books API key
const String googleBooksApiKey = 'AIzaSyC528A8IvyTAHI_8xihahK5tVivc_6MDM0';

class BookListWidget extends StatefulWidget {
  @override
  _BookListWidgetState createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {
  List<dynamic> allBooks = []; // To store books from all genres
  List<dynamic> filteredBooks = []; // Books filtered by search and genre
  bool isLoading = true;
  String _selectedSort = 'A-Z'; // Default sort option
  String _selectedGenre = 'All'; // Default genre (All books)
  TextEditingController _searchController = TextEditingController();

  // Genres to filter by
 final List<String> availableGenres = [
  'All', // Option to show all genres
  'Fiction',
  'Fantasy',
  'Action',
  'Poetry', // Added Poetry genre
  'Art', // Added Art genre
  'Education', // Added Education genre
  'History', // Added History genre
  'Law', // Added Law genre
  'Nature', // Added Nature genre
  'Photography', // Added Photography genre
  'Psychology', // Added Psychology genre
  'Mathematics', // Added Mathematics genre
  'Cooking', // Added Cooking genre
  'Travel',
];


  @override
  void initState() {
    super.initState();
    fetchBooks(); // Fetch all books initially
  }

  // Fetch books based on the selected genre
Future<void> fetchBooks() async {
  try {
    final genres = _selectedGenre == 'All'
        ? [
            'Fiction', 'Fantasy', 'Action', 'Poetry',
            'Art', 'Education', 'History', 'Law', 'Nature',
            'Photography', 'Psychology', 'Mathematics', 'Cooking', 'Travel'
          ] 
        : [_selectedGenre]; // Fetch only the selected genre

    final List<Future<http.Response>> requests = genres.map((genre) {
      final url =
          'https://www.googleapis.com/books/v1/volumes?q=subject:$genre&maxResults=5&key=$googleBooksApiKey';
      return http.get(Uri.parse(url));
    }).toList();

    final responses = await Future.wait(requests);

    List<dynamic> books = [];
    for (var response in responses) {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        books.addAll(data['items'] ?? []);
      } else {
        debugPrint('Error fetching books: ${response.statusCode}');
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
    if (_selectedSort == 'A-Z') {
      filteredBooks.sort((a, b) {
        final titleA = a['volumeInfo']['title'] ?? '';
        final titleB = b['volumeInfo']['title'] ?? '';
        return titleA.compareTo(titleB);
      });
    } else if (_selectedSort == 'Z-A') {
      filteredBooks.sort((a, b) {
        final titleA = a['volumeInfo']['title'] ?? '';
        final titleB = b['volumeInfo']['title'] ?? '';
        return titleB.compareTo(titleA);
      });
    }
    setState(() {});
  }

  void filterBooks(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredBooks = allBooks;
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

  Widget _buildBookGrid(List<dynamic> bookList) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 200 / 300,
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
                            height: 20,
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: TextField(
                              controller: _searchController,
                              onChanged: filterBooks,
                              decoration: InputDecoration(
                                hintText: 'Search by title or author...',
                                hintStyle: const TextStyle(
                                  color: Color(0xffe3eed4),
                                  fontSize: 14,
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                filled: true,
                                fillColor: const Color(0xff293d3e),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.search,
                                    color: Color(0xffe3eed4),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          // Combined Row for Genre and Sort Dropdowns, Centered
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Sort Dropdown (now first)
                                Container(
                                  width: 150, // Adjusted width for the container
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff293d3e),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14.0), // Padding for alignment
                                    child: DropdownButton<String>(
                                      value: _selectedSort, // Using the sort dropdown as an example
                                      dropdownColor: const Color(0xff293d3e),
                                      borderRadius: BorderRadius.circular(24),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedSort = newValue!;
                                          sortBooks();
                                        });
                                      },
                                      items: <String>[
                                        'A-Z',
                                        'Z-A',
                                      ].map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(color: Color(0xffe3eed4)),
                                          ),
                                        );
                                      }).toList(),
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Color(0xffe3eed4),
                                      ), // Positioned to the right by default
                                      isExpanded: true, // Ensures the icon stays aligned
                                      underline: Container(
                                        height: 1, // Adjust the height of the underline
                                        color: const Color(0xff293d3e), // Replace with your desired color
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 50),
                                // Genre Dropdown (now second)
                                Container(
                                  width: 150, // Reduced width for Genre
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff293d3e),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14.0), // Padding inside
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
                                          )
                                          .toList(),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Color(0xffe3eed4),
                                          ), // Positioned to the right by default
                                          isExpanded: true, // Ensures the icon stays aligned
                                          underline: Container(
                                            height: 1, // Adjust the height of the underline
                                            color: const Color(0xff293d3e), // Replace with your desired color
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
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
