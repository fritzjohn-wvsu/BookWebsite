import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'route_manager.dart';
import 'search.dart';

class navigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<navigationBar> {
  final TextEditingController searchController = TextEditingController();
  late Future<Map<String, String>> _userInfoFuture;

  Widget buildNavItem(String title, String routeName) {
    return ValueListenableBuilder<String>(
      valueListenable: RouteManager.currentRoute,
      builder: (context, currentRoute, child) {
        bool isActive = currentRoute == routeName;
        return TextButton(
          onPressed: () {
            RouteManager.currentRoute.value = routeName;
            Navigator.pushNamed(context, routeName);
          },
          style: TextButton.styleFrom(
            backgroundColor:
                isActive ? const Color(0xffe3eed4) : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isActive
                  ? const Color.fromARGB(255, 0, 15, 22)
                  : const Color(0xffe3eed4),
              fontSize: 15,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      },
    );
  }

  Future<Map<String, String>> _getUserInfoFromFirestore(String email) async {
    final firestoreInstance = FirebaseFirestore.instance;
    try {
      QuerySnapshot userDocs = await firestoreInstance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userDocs.docs.isNotEmpty) {
        var userDoc = userDocs.docs.first;
        String userName = userDoc['username'] ?? 'No name';
        String emailAddress = userDoc['email'] ?? 'No email';
        return {'userName': userName, 'emailAddress': emailAddress};
      } else {
        throw Exception('No user found with that email address.');
      }
    } catch (e) {
      print('Error fetching user info from Firestore: $e');
      rethrow;
    }
  }

  void _showDropdown(BuildContext context, Offset offset) async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    try {
      Map<String, String> userInfo =
          await _getUserInfoFromFirestore(user.email!);

      _showMenuWithUserInfo(context, offset, userInfo);
    } catch (e) {
      print("Error fetching user info: $e");
    }
  }

  void _showMenuWithUserInfo(
    BuildContext context,
    Offset offset,
    Map<String, String> userInfo,
  ) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + 40,
        0,
        0,
      ),
      items: [
        PopupMenuItem<String>(
          height: 50,
          child: Text('Username: ${userInfo['userName']}'),
        ),
        PopupMenuItem<String>(
          height: 50,
          child: Text('Email Address: ${userInfo['emailAddress']}'),
        ),
        PopupMenuItem<String>(
          height: 30,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/favorite');
            },
            child: const Text('Favorite Books',
                style: TextStyle(color: Colors.black)),
          ),
        ),
        PopupMenuItem<String>(
          enabled: false,
          child: SizedBox(height: 2),
        ),
        PopupMenuItem<String>(
          height: 50,
          child: Center(
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
        ),
      ],
      color: const Color(0xFFE3EED4),
    );
  }

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userInfoFuture = _getUserInfoFromFirestore(user.email!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 0, 15, 22),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                RouteManager.currentRoute.value = '/homepage';
                Navigator.pushNamed(context, '/homepage');
              },
              child: Row(
                children: [
                  Image.asset('assets/icon1.png', width: 50, height: 50),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildNavItem('Home', '/homepage'),
                  const SizedBox(width: 30),
                  buildNavItem('About', '/about'),
                  const SizedBox(width: 30),
                  buildNavItem('Books', '/books'),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  width: 250,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xffe3eed4),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SearchPage(query: searchController.text),
                            ),
                          );
                        },
                      ),
                    ),
                    onSubmitted: (query) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(query: query),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTapDown: (details) {
                    final offset = details.globalPosition;
                    _showDropdown(context, offset);
                  },
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: Color(0xffe3eed4),
                    child: Icon(
                      Icons.account_circle,
                      size: 45,
                      color: Color.fromARGB(255, 0, 15, 22),
                    ),
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
