import 'package:_2geda/APIServices/event_api_service.dart';
import 'package:_2geda/models/ticket.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/ticketPages/buyTicket/presentation/comps/all_promoted_events.dart';
import 'package:_2geda/pages/ticketPages/buyTicket/presentation/states/event_loading_state.dart';
import 'package:_2geda/pages/ticketPages/sellTicket/services/fetch_promoted_events.dart';
import 'package:_2geda/pages/widgets/ticket/presentation/comps/ticket_list.dart';
import 'package:flutter/material.dart';

class PromotionEvent extends StatefulWidget {
  const PromotionEvent({super.key});

  @override
  State<PromotionEvent> createState() => _PromotionEventState();
}

class _PromotionEventState extends State<PromotionEvent> {
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
                "Promoted events",
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
                        builder: (context) =>  AllPromotedEvents()),
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
        FutureBuilder<List<Event>>(
          future: getPromotedEvents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerLoadingEventRow();
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error loading tickets: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return TicketListWidget(events: snapshot.data ?? []);
            }
          },
        ),
      ],
    );
  }
}
