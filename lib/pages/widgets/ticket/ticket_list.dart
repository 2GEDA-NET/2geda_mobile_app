import 'package:_2geda/APIServices/event_api_service.dart';
import 'package:_2geda/models/ticket.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:flutter/material.dart';
import 'ticket_widget.dart';

class TicketListWidget extends StatefulWidget {
  const TicketListWidget({super.key});

  @override
  _TicketListWidgetState createState() => _TicketListWidgetState();
}

class _TicketListWidgetState extends State<TicketListWidget> {
  late List<Ticket> tickets = []; // Initialize tickets as an empty list
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
      List<Ticket> fetchedTickets =
          await ticketApiService.getTickets(authToken!);

      // Update the state with the fetched tickets
      if (mounted) {
        setState(() {
          tickets = fetchedTickets.cast<Ticket>();
        });
      }
    } catch (e) {
      // Handle errors, e.g., show an error message
      print('Error loading tickets: $e');
    }
  }

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
        date: ticket.dateFormatted,
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
