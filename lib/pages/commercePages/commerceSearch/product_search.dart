import 'package:_2geda/pages/commercePages/commerceSearch/product_search_grid.dart';
import 'package:_2geda/pages/commercePages/commerceSearch/sortPages/sort_by_category.dart';
import 'package:_2geda/pages/commercePages/commerceSearch/sortPages/sort_by_location.dart';
import 'package:_2geda/pages/homeScreens/searchPages/search_result.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: ProductSearchScreen(),
  ));
}

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<ProductSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Function to navigate to search results page
  void navigateToSearchResults(String query) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          SearchResultsPage(query: query), // Pass the query parameter here
    ));
  }

  void _showSortBottomSheet(BuildContext context) {
    RangeValues priceRange = const RangeValues(
        10, 5000000); // Set initial values within the specified range

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align children to start
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sort by",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              // Add more widgets as needed
              const Divider(),
              const SizedBox(
                height: 3,
              ),

              const Text(
                "Time posted",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Past 24hrs",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Last week",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("All time",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),

              const Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '\$${priceRange.start.toStringAsFixed(0)}', // Update the minimum price value
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const TextSpan(
                          text: " to",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        TextSpan(
                          text:
                              " \$${priceRange.end.toStringAsFixed(0)}", // Display the maximum price value
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),

              RangeSlider(
                values: priceRange,
                min: 10,
                max: 5000000,
                onChanged: (RangeValues newValues) {
                  setState(() {
                    priceRange = newValues;
                  });
                },
                labels: RangeLabels(
                  '\$${priceRange.start.toStringAsFixed(0)}',
                  '\$${priceRange.end.toStringAsFixed(0)}',
                ),
              ),
              const Divider(),
              // const SizedBox(
              //   height: 3,
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Category",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SortByCategory(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Text("Automobile",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            )),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        )
                      ],
                    ),
                  )
                ],
              ),
              // const SizedBox(
              //   height: 3,
              // ),

              const Divider(),
              // const SizedBox(
              //   height: 3,
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Location",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SortByLocation(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Text("Show all",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            )),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        )
                      ],
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  minimumSize: const Size(500, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Apply",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
                icon: const Icon(Icons.cancel, color: Color(0xff4e0ca2)),
                onPressed: () {
                  String query = _searchController.text;
                  if (query.isNotEmpty) {
                    navigateToSearchResults(
                        query); // Navigate to search results page
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.sort_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              _showSortBottomSheet(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "We found 54 results",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const ProductGridList(),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              "assets/banner.png",
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              height: 42,
            ),
            const SizedBox(
              height: 10,
            ),
            const ProductGridList(),
          ],
        ),
      ),
    );
  }
}
