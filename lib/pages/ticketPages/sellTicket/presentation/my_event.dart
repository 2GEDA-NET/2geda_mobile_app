import 'package:_2geda/models/ticket.dart';
import 'package:_2geda/pages/ticketPages/sellTicket/presentation/state/events_loading_state.dart';
import 'package:_2geda/pages/ticketPages/sellTicket/services/fetch_active_events.dart';
import 'package:_2geda/pages/widgets/ticket/presentation/comps/event_card.dart';
import 'package:_2geda/pages/widgets/ticket/presentation/comps/past_event_card.dart';
import 'package:flutter/material.dart';

class MyEventsPage extends StatelessWidget {
  MyEventsPage({
    Key? key,
  }) : super(key: key);

  late List<Event> activeEvents = [];

  late List<Event> upcomingEvents = [];

  late List<Event> pastEvents = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Define the number of tabs
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            'My Events',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/2geda-purple.png'),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upcoming'), // Replace with your tab titles
              Tab(text: 'Active events'),
              Tab(text: 'Past events'),
            ],
            labelColor: Colors.black,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<List<Event>>(
                      future: getActiveEvents(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return RecentEventLoadingState();
                        } else if (snapshot.hasError) {
                          print('Error: ${snapshot.error}');
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No active events available.');
                        } else {
                          return ListView(
                            children: snapshot.data!.map((event) {
                              return EventCard(eventData: event);
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: activeEvents.map((activeEvents) {
                        return EventCard(eventData: activeEvents);
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: pastEvents.map((pastEvents) {
                        return PastEventCard(eventData: pastEvents);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
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
