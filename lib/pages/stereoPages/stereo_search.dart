// ignore_for_file: library_private_types_in_public_api

import 'package:_2geda/pages/stereoPages/stereo_search_result.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: StereoSearchScreen(),
  ));
}

class StereoSearchScreen extends StatefulWidget {
  const StereoSearchScreen({super.key});

  @override
  _StereoSearchScreenState createState() => _StereoSearchScreenState();
}

class _StereoSearchScreenState extends State<StereoSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = []; // List to store recent searches

  void addToRecentSearches(String query) {
    setState(() {
      recentSearches.add(query);
    });
  }

  // Function to clear all recent searches
  void clearRecentSearches() {
    setState(() {
      recentSearches.clear();
    });
  }

  // Function to navigate to search results page
  void navigateToSearchResults(String query) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          StereoSearchResultsPage(query: query), // Pass the query parameter here
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xC9000000)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: const Color(0xfff5f5f5),
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.search, color: Colors.black),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Color(0xff4e0ca2)),
                onPressed: () {
                  String query = _searchController.text;
                  if (query.isNotEmpty) {
                    addToRecentSearches(query);
                    navigateToSearchResults(
                        query); // Navigate to search results page
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text("Recent searches",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                TextButton(
                  onPressed: () {
                    clearRecentSearches();
                  },
                  child: const Text(
                    'Clear all',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recentSearches.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          recentSearches[index],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.clear,
                          size: 10,
                        ),
                        onPressed: () {
                          setState(() {
                            recentSearches.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    navigateToSearchResults(recentSearches[
                        index]); // Navigate to search results page
                  },
                );
              },
            ),
          ),
          Image.asset(
            "assets/banner.png",
            width:
                MediaQuery.of(context).size.width, // Set width to screen width
            height: 42,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
