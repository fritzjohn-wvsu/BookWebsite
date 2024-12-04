import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'bookDetails.dart';
import 'navigation.dart'; 

// Your Google Books API key
const String googleBooksApiKey = 'AIzaSyDoVXygeRZe-s07DSFWQFcO5ITv1juwN34';

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


//sort the books to a-z to z-a
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
  } else if (_selectedSort == 'Newest') {
    filteredBooks.sort((a, b) {
      final dateA = DateTime.tryParse(a['volumeInfo']['publishedDate'] ?? '') ?? DateTime(1900);
      final dateB = DateTime.tryParse(b['volumeInfo']['publishedDate'] ?? '') ?? DateTime(1900);
      return dateB.compareTo(dateA);
    });
  } else if (_selectedSort == 'Oldest') {
    filteredBooks.sort((a, b) {
      final dateA = DateTime.tryParse(a['volumeInfo']['publishedDate'] ?? '') ?? DateTime(1900);
      final dateB = DateTime.tryParse(b['volumeInfo']['publishedDate'] ?? '') ?? DateTime(1900);
      // Treat invalid dates as the last item
      if (dateA.year == 1900 && dateB.year == 1900) {
        return 0; // Both are invalid, keep the order as it is
      } else if (dateA.year == 1900) {
        return 1; // Place invalid dates after valid ones
      } else if (dateB.year == 1900) {
        return -1; // Place invalid dates after valid ones
      }
      return dateA.compareTo(dateB);  // Sort valid dates from oldest to newest
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
      itemCount: bookList.length, // build the descriptions
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
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff293d3e),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                    child: DropdownButton<String>(
                                  value: _selectedSort,
                                  items: ['A-Z', 'Z-A', 'Newest', 'Oldest']
                                      .map((sortOption) => DropdownMenuItem(
                                            value: sortOption,
                                            child: Text(
                                              sortOption,
                                              style: const TextStyle(color: Color(0xffe3eed4)),
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
                                  style: const TextStyle(color: Color(0xffe3eed4)),

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
                                    padding: const EdgeInsets.symmetric(horizontal: 14.0), 
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