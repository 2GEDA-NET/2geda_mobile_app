// account_screen.dart

import 'package:_2geda/APIServices/event_api_service.dart';
import 'package:_2geda/models/ticket.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/ticketPages/buyTicket/all_popular_events.dart';
import 'package:_2geda/pages/widgets/ticket/ticket_list.dart';
import 'package:flutter/material.dart';

class PopularEvent extends StatefulWidget {
  const PopularEvent({super.key});

  @override
  State<PopularEvent> createState() => _PopularEventState();
}

class _PopularEventState extends State<PopularEvent> {
  late List<Event> events = []; // Initialize tickets as an empty list

  final TokenManager tokenManager = TokenManager();
  String? authToken;

  @override
  void initState() {
    super.initState();
    _loadTickets();
  }

  Future<void> _loadTickets() async {
    try {
      // Instantiate the TicketApiService
      TicketApiService ticketApiService = TicketApiService();

      // Fetch the auth token
      authToken = await tokenManager.getToken();

      // Fetch tickets from the API
      List<Event> fetchedTickets =
          await ticketApiService.getTickets(authToken!);

      // Update the state with the fetched tickets
      if (mounted) {
        setState(() {
          events = fetchedTickets.cast<Event>();
        });
      }
    } catch (e) {
      // Handle errors, e.g., show an error message
      print('Error loading tickets: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Popular events",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllPopularEvents(),
                    ),
                  );
                },
                child: const Text(
                  "View all",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
       TicketListWidget(events: events,),
      ],
    );
  }
}
