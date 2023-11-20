import 'package:_2geda/data/ticket_data.dart';
import 'package:_2geda/models/ticket.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class MyEventsPage extends StatelessWidget {
  const MyEventsPage({super.key});

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
                      children: ticketsData.map((ticket) {
                        return EventCard(eventData: ticket);
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: ticketsData.map((ticket) {
                        return EventCard(eventData: ticket);
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: ticketsData.map((ticket) {
                        return PastEventCard(eventData: ticket);
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

class EventCard extends StatelessWidget {
  final Ticket eventData;

  const EventCard({Key? key, required this.eventData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 90,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      eventData.coverImageUrl,
                    ),
                    fit: BoxFit
                        .cover, // You can adjust the fit as needed (e.g., BoxFit.fill)
                  ),
                ),
                // The rest of your Container content goes here
              ),
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventData.title,
                      style: const TextStyle(
                        fontSize: 15.2809,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      eventData.date as String,
                      style: const TextStyle(
                        fontSize: 13.3708,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4e0ca2),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      eventData.location,
                      style: const TextStyle(
                        fontSize: 13.3708,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      eventData.description,
                      style: const TextStyle(
                        fontSize: 11.4607,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle Edit button press
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return EditDialog(eventData: eventData);
                    },
                  );
                },
                child: const Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 5),
                    Text('Edit'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle Summary button press
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SummaryDialog(eventData: eventData);
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xff4e0ca2),
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xff4e0ca2), width: 1.0),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.summarize),
                    SizedBox(width: 5),
                    Text('Summary'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle Report button press
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xff4e0ca2),
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xff4e0ca2), width: 1.0),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.report),
                    SizedBox(width: 5),
                    Text('Report'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PastEventCard extends StatelessWidget {
  final Ticket eventData;

  const PastEventCard({Key? key, required this.eventData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 90,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      eventData.coverImageUrl,
                    ),
                    fit: BoxFit
                        .cover, // You can adjust the fit as needed (e.g., BoxFit.fill)
                  ),
                ),
                // The rest of your Container content goes here
              ),
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventData.title,
                      style: const TextStyle(
                        fontSize: 15.2809,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      eventData.date as String,
                      style: const TextStyle(
                        fontSize: 13.3708,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4e0ca2),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      eventData.location,
                      style: const TextStyle(
                        fontSize: 13.3708,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      eventData.description,
                      style: const TextStyle(
                        fontSize: 11.4607,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Summary button press
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SummaryDialog(eventData: eventData);
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xff4e0ca2),
                    backgroundColor: Colors.white,
                    side:
                        const BorderSide(color: Color(0xff4e0ca2), width: 1.0),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.summarize),
                      SizedBox(width: 5),
                      Text('Summary'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Report button press
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xff4e0ca2),
                    backgroundColor: Colors.white,
                    side:
                        const BorderSide(color: Color(0xff4e0ca2), width: 1.0),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.report),
                      SizedBox(width: 5),
                      Text('Report'),
                    ],
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

class EditDialog extends StatelessWidget {
  final Ticket eventData;
  EditDialog({Key? key, required this.eventData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement your edit dialog content here
    return AlertDialog(
      title: const Text('Edit Event'),
      content: const SizedBox(), // Your form fields for editing event details,
      actions: [
        TextButton(
          onPressed: () {
            // Handle Save button press
            // Update the event data and close the dialog
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () {
            // Close the dialog without saving changes
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

class SummaryDialog extends StatelessWidget {
  final Ticket eventData;

  SummaryDialog({Key? key, required this.eventData}) : super(key: key);

  void copyToClipboard(BuildContext context, String textToCopy) {
    FlutterClipboard.copy(textToCopy).then((_) {
      final snackBar = SnackBar(
        backgroundColor: const Color(0xff4e0ca2),
        content: Text('Copied to clipboard: $textToCopy'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((error) {
      final snackBar = SnackBar(
        content: Text('Failed to copy to clipboard: $error'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  static const url = 'https://2geda.net/tickets/ID1298';

  @override
  Widget build(BuildContext context) {
    // Implement your summary dialog content here
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      title: Stack(
        children: [
          CachedNetworkImage(imageUrl: eventData.coverImageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Spacer(),
                Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(205, 255, 255, 255)),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.all(8),
      content: SizedBox(
        height: 350,
        child: Column(
          children: [
            const Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Event title",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                    Text("Music seasonal festival II",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Date",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                    Text("27 Aug 2023",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Location",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                    Text("Eko Hotel and suites conference hall 1.",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Time",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                    Text("09:00 PM",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 224, 224, 224),
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      url,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        copyToClipboard(context, url);
                      },
                      icon: const Icon(
                        Icons.copy,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Column(
                    children: [
                      Text("VIP",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      Text("50 tickets",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ))
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text("30 sold",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      )
                    ],
                  ),
                  const Spacer(),
                  const Row(
                    children: [
                      Text("3,000.00",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ))
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Column(
                    children: [
                      Text("Regular",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      Text("50 tickets",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ))
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text("30 sold",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      )
                    ],
                  ),
                  const Spacer(),
                  const Row(
                    children: [
                      Text("3,000.00",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ), // Display the event summary information,
    );
  }
}
