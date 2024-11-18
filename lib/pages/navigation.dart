import 'package:flutter/material.dart';

Widget navigationBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      // Left side content: Logo and LITFinds text
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'icon.png',
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () {},
            child: const Text(
              'LITFinds',
              style: TextStyle(
                color: Color(0xffe3eed4),
                fontFamily: "TanMerigue",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      // Middle content: Home, About, Books
      Row(
        children: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Home',
              style: TextStyle(color: Color(0xffe3eed4), fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'About',
              style: TextStyle(color: Color(0xffe3eed4), fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Books',
              style: TextStyle(color: Color(0xffe3eed4), fontSize: 15),
            ),
          ),
        ],
      ),
      // Right side content: Search bar and user icon
      Row(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            width: 250,
            height: 40,
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 0, 15, 22),
                    size: 18,
                  ),
                ),
                Expanded(
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 15, 22),
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // User icon
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Color(0xffe3eed4),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Color.fromARGB(255, 0, 15, 22),
              size: 25,
            ),
          ),
        ],
      ),
    ],
  );
}
