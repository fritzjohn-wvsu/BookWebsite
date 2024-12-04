import 'package:flutter/material.dart';
import 'navigation.dart';
import 'bodysection.dart';
import 'popular.dart';
import 'update.dart';
import 'footer.dart';
import 'route_manager.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    RouteManager.currentRoute.value = '/home';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 60), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.05),
                bodySection(context), 
                SizedBox(height: screenHeight * 0.2),
                popularBook(), 
                SizedBox(height: screenHeight * 0.1),
                updateList(context), 
                SizedBox(height: screenHeight * 0.1),
                FooterPage(), 
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              child: navigationBar(context),
            ),
          ),
        ],
      ),
    );
  }
}
