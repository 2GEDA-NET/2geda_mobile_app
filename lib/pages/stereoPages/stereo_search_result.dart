import 'package:flutter/material.dart';

class StereoSearchResultsPage extends StatefulWidget {
  final String query;

  const StereoSearchResultsPage({super.key, required this.query});

  @override
  _StereoSearchResultsPageState createState() => _StereoSearchResultsPageState();
}

class _StereoSearchResultsPageState extends State<StereoSearchResultsPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

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
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: widget.query,
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear, color: Colors.black),
                      onPressed: () {
                        // Clear the search query
                        Navigator.pop(context, ''); // Return an empty query
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            // color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buildTabButtons(),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: const [
                Center(child: Text('All Tab Content')),
                Center(child: Text('People Tab Content')),
                Center(child: Text('Media Tab Content')),
              ],
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

  List<Widget> buildTabButtons() {
    final tabLabels = ['All', 'Songs', 'Artist',];

    return tabLabels.asMap().entries.map((entry) {
      final index = entry.key;
      final label = entry.value;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _currentIndex == index ? const Color(0xff4f0da3) : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Adjust the radius as needed
                ),
              ),
              onPressed: () {
                // Update the PageView when a tab button is pressed
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                label,
                style: TextStyle(
                  color: _currentIndex == index ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}
