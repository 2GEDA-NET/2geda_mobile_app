import 'package:_2geda/models/ticket.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/ticketPages/buyTicket/services/fetch_promoted_events.dart';
import 'package:_2geda/pages/ticketPages/sellTicket/presentation/state/events_loading_state.dart';
import 'package:_2geda/pages/widgets/ticket/presentation/comps/ticket_card2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AllPromotedEvents extends StatelessWidget {
   AllPromotedEvents({super.key});

  late List<Event> events = []; 
 // Initialize tickets as an empty list
  final TokenManager tokenManager = TokenManager();

  String? authToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Promoted Events',
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
                  future: getPromotedEvents(),
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
