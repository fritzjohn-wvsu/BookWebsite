import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'navigation.dart'; // Import the navigation bar file

class BookList extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookList> {
  List<dynamic> meals = [];

  @override
  void initState() {
    super.initState();
    fetchMeals(); // Fetch meals when the page is initialized
  }

  // Fetch meal data from TheMealDB API
  Future<void> fetchMeals() async {
    final url =
        //https://www.googleapis.com/books/v1/volumes?q=a&key=AIzaSyBKsd3N8K0L4d6I-UZf5sOQE5LHWvdyPbk
        'https://www.themealdb.com/api/json/v1/1/search.php?f=b'; // API link for meals starting with 'A'
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        meals = data['meals'] ?? []; // Use the 'meals' data
      });
    } else {
      throw Exception('Failed to load meals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          navigationBar(context), // Call the navigationBar widget here
          // Remove the SizedBox or Padding between navigation and BookList
          Expanded(
            child: meals.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  ) // Show loading indicator
                : SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 15,
                            22), // Set the container background color
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title for the meals section
                          const Text(
                            "Book List",
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xffe3eed4), // Light text color
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(
                            color: Color(0xffe3eed4),
                            thickness: 1,
                            height: 20,
                          ),
                          const SizedBox(height: 25),
                          // Row of small rectangles for meals (Meals 1 to 5)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: meals
                                .sublist(
                                    0,
                                    meals.length > 5
                                        ? 5
                                        : meals.length) // Safe sublist
                                .map((meal) => _bookRectangle(
                                    meal['strMeal'],
                                    meal[
                                        'strMealThumb'])) // Passing meal name and image URL
                                .toList(),
                          ),
                          const SizedBox(height: 25),
                          // Row of small rectangles for meals (Meals 6 to 10)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: meals.length > 5
                                ? meals
                                    .sublist(5,
                                        meals.length > 10 ? 10 : meals.length)
                                    .map((meal) => _bookRectangle(
                                        meal['strMeal'], meal['strMealThumb']))
                                    .toList()
                                : [], // Empty row if less than 6 meals
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Helper widget to create a rectangle for each meal inside a book-like style
  Widget _bookRectangle(String mealName, String imageUrl) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 300,
          color: const Color(0xffe3eed4), // Light color for the container
          child: imageUrl != null && imageUrl.isNotEmpty
              ? Image.network(imageUrl, fit: BoxFit.cover)
              : const Icon(Icons.restaurant,
                  size: 100, color: Colors.grey), // Default icon if no image
        ),
        const SizedBox(height: 10),
        Text(
          mealName,
          style: const TextStyle(
            color: Color(0xffe3eed4), // Text color
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
