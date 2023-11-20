// ignore_for_file: library_private_types_in_public_api

import 'package:_2geda/pages/homeScreens/create_post.dart';
import 'package:_2geda/pages/homeScreens/lifestyles.dart';
import 'package:_2geda/pages/homeScreens/post_feeds.dart';
import 'package:_2geda/pages/widgets/appbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                CustomAppBar(),
              ];
            },
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Image.asset(
                    "assets/banner2.png",
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                  ),
                  const Lifestyle(),
                  const PostFeed(),
                ],
              ),
            ),
          ),
          // SideBarLayout(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              // Add your onPressed logic for the first button here
            },
            backgroundColor:
                const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
            // backgroundColor: const Color(0xff4e0ca2).withOpacity(0.3),
            child: Image.asset(
              'assets/customer_support.png',
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              // Add your onPressed logic for the second button here
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PostCreationScreen(),
                ),
              );
            },
            backgroundColor: const Color(0xff4e0ca2),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
