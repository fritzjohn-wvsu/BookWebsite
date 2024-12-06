import 'package:main/pages/favoritespage.dart';
import '/pages/about.dart';
import '/pages/booklist.dart';
import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'pages/signup_page.dart';
import 'pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LITFinds',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 10, 1, 0),
        ),
        useMaterial3: true,
      ),
      // It calls the Signup page first
      initialRoute: '/login',
      // Different route choices
      routes: {
        '/signup': (context) => SignUp(),
        '/login': (context) => LoginPage(),
        '/homepage': (context) => Homepage(),
        '/about': (context) => About(),
        '/books': (context) => BookListWidget(),
        '/favorite': (context) => FavoriteBooksPage()
      },
    );
  }
}
