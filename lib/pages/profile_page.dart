import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart'; // Navigate back to the login page after logout

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Initialize variables to hold user data
  String username = '';
  String email = '';
  List<String> favoriteBooks = [];

  // Fetch user data and favorite books from Firestore
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        // Fetch user data from Firestore
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            username = userDoc['username'] ?? 'No username found';
            email = userDoc['email'] ?? 'No email found';
            favoriteBooks = List<String>.from(userDoc['favorite_books'] ?? []);
          });
        } else {
          print('No such document found for the user');
        }
      } catch (e) {
        // Handle any errors while fetching data
        print('Error fetching user data: $e');
      }
    }
  }

  // Function to handle logout
  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe3eed4),
        title: const Text(
          'Profile',
          style: TextStyle(color: Color(0xff0f0f0f)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display user name and email
            Text(
              'Username: $username',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: $email',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Display list of favorite books
            const Text(
              'Favorite Books:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            favoriteBooks.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: favoriteBooks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(favoriteBooks[index]),
                        );
                      },
                    ),
                  )
                : const Text('No favorite books added yet.'),
            const SizedBox(height: 20),

            // Logout button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: const Color(0xffe3eed4),
                ),
                onPressed: _logout,
                child: const Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0f0f0f),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
