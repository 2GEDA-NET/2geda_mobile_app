import 'package:_2geda/pages/ticketPages/buyTicket/presentation/event_catgories.dart';
import 'package:_2geda/pages/ticketPages/buyTicket/presentation/event_this_week.dart';
import 'package:_2geda/pages/ticketPages/buyTicket/presentation/popular_event.dart';
import 'package:_2geda/pages/ticketPages/buyTicket/presentation/promoted_events.dart';
import 'package:_2geda/pages/ticketPages/search_ticket_page.dart';
import 'package:_2geda/pages/widgets/people/user_list.dart';
import 'package:_2geda/pages/widgets/product/product_widget.dart';
import 'package:flutter/material.dart';

class BuyTicketPage extends StatelessWidget {
  const BuyTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Buy Ticket',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Discover events",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                height: 5,
              ),
              Text(
                "Great events are happening around you ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    // Wrap the TextFormField with Expanded
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.search), // Icon as a prefix
                        hintText: 'Find events', // Placeholder text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the radius as needed
                          borderSide: const BorderSide(
                            width: 2, // Set the border width
                          ),
                        ),
                      ),
                      // Add any other properties and handlers as needed
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1)),
                    child: IconButton(
                      icon: const Icon(Icons.sort),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SearchTicketPage(),
                            ),
                          );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/banner2.png'),
            ),
            const PopularEvent(),
            const PromotionEvent(),
            const ProductListWidget(),
            const EventThisWeek(),
            const EventCategory(),
            
            const UserListWidget(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/banner2.png'),
            )
          ],
        ),
      ),
    );
  }
}
