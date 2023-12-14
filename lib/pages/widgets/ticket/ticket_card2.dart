import 'package:_2geda/models/ticket.dart';
import 'package:_2geda/pages/ticketPages/event_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TicketList2Widget extends StatefulWidget {
  const TicketList2Widget({super.key});

  @override
  _TicketList2WidgetState createState() => _TicketList2WidgetState();
}

class _TicketList2WidgetState extends State<TicketList2Widget> {
  late List<Event> eventData; // Use the imported data

  @override
  Widget build(BuildContext context) {
    return buildTicketList();
  }

  Widget buildTicketList() {
    List<Widget> ticketWidgets = [];

    for (int index = 0; index < eventData.length; index++) {
      Event event = eventData[index];

      ticketWidgets.add(TicketWidget2(
        coverImageUrl: event.image,
        title: event.title,
        date: event.date.toLocal().toString(),
        location: event.location ?? event.platform,
      ));
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.68,
      child: ListView(
        children: ticketWidgets,
      ),
    );
  }
}

class TicketWidget2 extends StatelessWidget {
  final String coverImageUrl;
  final String title;
  final String date;
  final String location;

  const TicketWidget2({
    Key? key,
    required this.coverImageUrl,
    required this.title,
    required this.date,
    required this.location,
  }) : super(key: key);

  String truncateWithEllipsis(String text, int maxChars) {
    if (text.length <= maxChars) {
      return text;
    }
    return '${text.substring(0, maxChars)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(
                  10.0), // Adjust the border radius as needed
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: coverImageUrl,
                    width: 70, // Set the desired width
                    height: 300, // Set the desired height
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    right: 0,
                      child: Image.asset(
                    'assets/2geda-logo.png',
                    width: 20,
                    height: 20,
                  ))
                ],
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                      fontSize: 13.403409004211426,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4e0ca2)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15.318181991577148,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on),
                    Text(
                      truncateWithEllipsis(location, 30),
                      style: const TextStyle(
                        fontSize: 13.403409004211426,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Add action when the "Promote Event" button is pressed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .white, // Set the button background color to white
                  ),
                  child: const Text(
                    "Promote Event",
                    style: TextStyle(
                      color: Colors.black, // Set the text color to black
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Add action when the "Get Ticket" button is pressed
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EventDetailsPage(
                          // Pass event details to the EventDetailsPage widget
                          title: title,
                          date: date,
                          location: location,
                          coverImageUrl: coverImageUrl,
                          // Add any other event details as needed
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                        0xff4e0ca2), // Set the button background color to purple
                  ),
                  child: const Text(
                    "Get Ticket",
                    style: TextStyle(
                      color: Colors.white, // Set the text color to white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
