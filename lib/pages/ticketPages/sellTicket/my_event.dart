import 'package:_2geda/models/ticket.dart';
import 'package:_2geda/pages/widgets/ticket/event_card.dart';
import 'package:_2geda/pages/widgets/ticket/past_event_card.dart';
import 'package:flutter/material.dart';

class MyEventsPage extends StatelessWidget {
  final List<Event> events;

  const MyEventsPage({Key? key, required this.events}) : super(key: key);


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
                    child: ListView(
                      children: events.map((event) {
                        return EventCard(eventData: event);
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: events.map((event) {
                        return EventCard(eventData: event);
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: events.map((event) {
                        return PastEventCard(eventData: event);
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

