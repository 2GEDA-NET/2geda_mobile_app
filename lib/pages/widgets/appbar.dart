import 'package:_2geda/pages/homeScreens/searchPages/search_screen.dart';
import 'package:_2geda/pages/notification/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Use WillPopScope to intercept the back button press
        // Pop all routes and exit the app
        SystemNavigator.pop();
        return true; // Return true to allow exiting the app
      },
      child: SliverAppBar(
        elevation: 200,
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/2geda-purple.png',
            width: 40,
            height: 40,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Handle search button tap
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              // Handle notification button tap
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NotificationPage(),
                ),
              );
            },
            icon: Stack(
              children: <Widget>[
                const Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: 30,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 10,
                      minHeight: 10,
                    ),
                    child: const Text(
                      '6',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
        pinned: true,
      ),
    );
  }
}

import 'package:_2geda/pages/homeScreens/searchPages/search_screen.dart';
import 'package:_2geda/pages/notification/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Use WillPopScope to intercept the back button press
        // Pop all routes and exit the app
        SystemNavigator.pop();
        return true; // Return true to allow exiting the app
      },
      child: SliverAppBar(
        elevation: 200,
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/2geda-purple.png',
            width: 40,
            height: 40,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Handle search button tap
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              // Handle notification button tap
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NotificationPage(),
                ),
              );
            },
            icon: Stack(
              children: <Widget>[
                const Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: 30,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 10,
                      minHeight: 10,
                    ),
                    child: const Text(
                      '6',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
        pinned: true,
      ),
    );
  }
}
