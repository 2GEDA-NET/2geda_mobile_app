import 'package:_2geda/APIServices/event_api_service.dart';
import 'package:_2geda/models/ticket.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/ticketPages/buyTicket/services/fetch_weekly_events.dart';
import 'package:_2geda/pages/ticketPages/sellTicket/presentation/state/events_loading_state.dart';
import 'package:_2geda/pages/widgets/ticket/presentation/comps/ticket_card2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AllWeeklyEvents extends StatefulWidget {
  const AllWeeklyEvents({super.key});

  @override
  State<AllWeeklyEvents> createState() => _AllWeeklyEventsState();
}

class _AllWeeklyEventsState extends State<AllWeeklyEvents> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Events this Week',
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search), // Icon as a prefix
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
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder<List<Event>>(
                  future: getWeeklyEvents(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return RecentEventLoadingState();
                    } else if (snapshot.hasError) {
                      if (kDebugMode) {
                        print('Error: ${snapshot.error}');
                      }
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No active events available.');
                    } else {
                      return TicketList2Widget(
                        eventData: events,
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/banner2.png'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
