import 'package:intl/intl.dart';

class Ticket {
  final int id;
  final String coverImageUrl;
  final String title;
  final DateTime date;
  final String description;
  final String location;
  final String dateFormatted; // Add this line

  Ticket({
    required this.id,
    required this.coverImageUrl,
    required this.title,
    required this.date,
    required this.description,
    required this.location,
    required this.dateFormatted,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat('EEE, dd MMM yyyy, h:mm a');

    return Ticket(
      id: json['id'] ?? 0,
      coverImageUrl: json['coverImageUrl'] ?? 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8ZXZlbnR8ZW58MHx8MHx8fDA%3D',
      title: json['title'] ?? '',
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      dateFormatted: json['date'] != null
          ? formatter.format(DateTime.parse(json['date']))
          : '', // Format the date if it's not null, otherwise use an empty string
    );
  }
}

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final Ticket ticket;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.ticket,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['desc'] ?? '',
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      location: json['location'] ?? '',
      ticket: Ticket.fromJson(json['ticket'] ?? {}),
    );
  }

  Ticket toTicket() {
    final DateFormat formatter = DateFormat('EEE, dd MMM yyyy, h:mm a');

    return Ticket(
      id: int.parse(id),
      coverImageUrl:
          '', // Add the correct property from Event or adjust accordingly
      title: title,
      date: DateTime.parse(date.toIso8601String()),
      description: description,
      location: location,
      dateFormatted: formatter.format(date), // Format the date as needed
    );
  }
}

class TicketData {
  final String name;
  final String id;
  final String ticketType;
  final String date;
  final String price;

  TicketData(this.name, this.id, this.ticketType, this.date, this.price);
}
