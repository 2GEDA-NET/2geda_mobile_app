import 'package:_2geda/data/ticket_data.dart';
import 'package:_2geda/models/ticket.dart';
import 'package:flutter/material.dart';
import 'ticket_widget.dart';

class TicketListWidget extends StatefulWidget {
  const TicketListWidget({super.key});

  @override
  _TicketListWidgetState createState() => _TicketListWidgetState();
}

class _TicketListWidgetState extends State<TicketListWidget> {
  late List<Ticket> tickets = ticketsData; // Use the imported data

  @override
  Widget build(BuildContext context) {
    return buildTicketList();
  }

  Widget buildTicketList() {
    List<Widget> ticketWidgets = [];

    for (int index = 0; index < tickets.length; index++) {
      Ticket ticket = tickets[index];

      ticketWidgets.add(TicketWidget(
        coverImageUrl: ticket.coverImageUrl,
        title: ticket.title,
        date: ticket.date,
        location: ticket.location,
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ticketWidgets,
      ),
    );
  }
}
