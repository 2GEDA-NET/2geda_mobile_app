import 'package:_2geda/models/ticket.dart';
import 'package:_2geda/pages/ticketPages/buyTicket/presentation/comps/all_popular_events.dart';
import 'package:_2geda/pages/ticketPages/buyTicket/presentation/states/event_loading_state.dart';
import 'package:_2geda/pages/ticketPages/buyTicket/services/fetch_popular_events.dart';
import 'package:_2geda/pages/widgets/ticket/presentation/comps/ticket_list.dart';
import 'package:flutter/material.dart';

class PopularEvent extends StatelessWidget {
  PopularEvent({super.key});

  late List<Event> events = [];
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
        //  TicketListWidget(events: events,),
        FutureBuilder<List<Event>>(
          future: getPopularEvents(),
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
