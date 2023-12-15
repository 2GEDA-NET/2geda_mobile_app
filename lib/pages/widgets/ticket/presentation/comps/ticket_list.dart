import 'package:_2geda/models/ticket.dart';
import 'package:flutter/material.dart';
import 'ticket_widget.dart';

class TicketListWidget extends StatelessWidget {
  late List<Event> events = []; // Initialize tickets as an empty list

  TicketListWidget({super.key, required this.events});

  // Future<void> _loadTickets() async {
  @override
  Widget build(BuildContext context) {
    return buildTicketList();
  }

  Widget buildTicketList() {
    List<Widget> eventWidgets = [];

    for (int index = 0; index < events.length; index++) {
      Event currentEvent = events[index];

      eventWidgets.add(TicketWidget(
        coverImageUrl: currentEvent.image ??
            '', // assuming you have an 'event' property in your Ticket model
        title: currentEvent.title ?? '',
        date: currentEvent.formatedDate ?? '',

        location: currentEvent.location ?? currentEvent.platform ?? '',
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: eventWidgets,
      ),
    );
  }
}
