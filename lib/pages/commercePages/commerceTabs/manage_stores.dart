import 'package:_2geda/data/product_data.dart';
import 'package:_2geda/pages/authentication/profile/business_profile_form.dart';
import 'package:_2geda/pages/commercePages/commerceTabs/my_store.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageStoreTab extends StatefulWidget {
  const ManageStoreTab({super.key});
  @override
  State<ManageStoreTab> createState() => _ManageStoreTabState();
}

class _ManageStoreTabState extends State<ManageStoreTab> {
  bool hasBusinessProfile = true;

  // Set this based on the API response.
  @override
  void initState() {
    super.initState();
    checkBusinessProfile();
  }

  Future<void> checkBusinessProfile() async {
    const apiUrl = 'http://1279:o97834'; // Replace with your actual API URL

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final hasUpdatedProfile = jsonData['has_updated_profile'] as bool;

        setState(() {
          hasBusinessProfile = hasUpdatedProfile == true;
        });
      } else {
        // Handle the case where the API request was not successful
      }
    } catch (e) {
      // Handle any errors that occurred during the API request
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!hasBusinessProfile) {
      return const BusinessProfileWidget();
    } else {
      return const ListOfStoresWidget();
    }
  }
}

class BusinessProfileWidget extends StatelessWidget {
  const BusinessProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/nothing_here.png'),
        const Text(
          "No business yet!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BusinessProfileFormPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffff8a15),
            minimumSize: const Size(150, 40),
          ),
          child: const Text("+ Create a Business account now",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              )),
        ),
      ],
    );
  }
}

class ListOfStoresWidget extends StatelessWidget {
  const ListOfStoresWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.696,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: storeItems.map((item) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MyStorePage(), // Replace with the actual screen
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                    imageUrl: item.imagePath,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        item.category,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Icon(Icons.more_horiz),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (storeItems.indexOf(item) <
                          storeItems.length -
                              1) // Add a divider if not the last item
                        const Divider(
                          height:
                              0.1, // You can adjust the height of the divider
                          color: Color.fromARGB(137, 158, 158,
                              158), // You can change the color of the divider
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                // Add your action when the button is pressed
                BusinessProfileFormPage();
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
