import 'package:flutter/material.dart';
import 'search.dart';
import 'route_manager.dart';

Widget navigationBar(BuildContext context) {
  final TextEditingController searchController = TextEditingController();

  // Function to style the nav item with active state
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
                Image.asset(
                  'assets/icon1.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          // Centered nav items
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
          // Search bar and Profile icon
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
                      icon: const Icon(Icons.search,
                          color: Color.fromARGB(255, 0, 15, 22)),
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
              // Profile Icon
              IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  size: 45,
                  color: Color(0xffe3eed4),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
