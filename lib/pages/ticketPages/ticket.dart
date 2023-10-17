import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: TicketPage(),
  ));
}

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Card(
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.event),
                    title: Text('Event Name'),
                    subtitle: Text('Date: December 31, 2023'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Venue'),
                    subtitle: Text('123 Main Street, Cityville'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.access_time),
                    title: Text('Time'),
                    subtitle: Text('8:00 PM - 10:00 PM'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.confirmation_number),
                    title: Text('Ticket ID'),
                    subtitle: Text('1234567890'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Ticket Holder Information',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Card(
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Name'),
                    subtitle: Text('John Doe'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('Email'),
                    subtitle: Text('johndoe@example.com'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Phone'),
                    subtitle: Text('+1 (123) 456-7890'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement action to view or download the ticket
              },
              child: const Text('View Ticket'),
            ),
          ],
        ),
      ),
    );
  }
}
