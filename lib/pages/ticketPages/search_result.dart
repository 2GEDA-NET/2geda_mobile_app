import 'package:_2geda/pages/widgets/ticket/ticket_card2.dart';
import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search), // Icon as a prefix
                hintText: 'Find events', // Placeholder text
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Adjust the radius as needed
                  borderSide: const BorderSide(
                    width: 2, // Set the border width
                  ),
                ),
              ),
              // Add any other properties and handlers as needed
            ),
            const TicketList2Widget(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/banner2.png'),
            ),
          ],
        ),
      ),
    );
  }
}
