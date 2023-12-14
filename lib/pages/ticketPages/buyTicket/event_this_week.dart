// account_screen.dart

import 'package:_2geda/pages/ticketPages/buyTicket/all_weekly_event.dart';
import 'package:_2geda/pages/widgets/ticket/ticket_list.dart';
import 'package:flutter/material.dart';

class EventThisWeek extends StatelessWidget {
  const EventThisWeek({super.key});

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
                "Events this week",
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
                        builder: (context) => const AllWeeklyEvents()),
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
        const TicketListWidget(),
      ],
    );
  }
}
