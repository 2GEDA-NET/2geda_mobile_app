// ticket.dart
class Ticket {
  final String coverImageUrl;
  final String title;
  final String date;
  final String description;
  final String location;

  Ticket({
    required this.coverImageUrl,
    required this.title,
    required this.date,
    required this.description,
    required this.location,
  });
}


class TicketData {
  final String name;
  final String id;
  final String ticketType;
  final String date;
  final String price;

  TicketData(this.name, this.id, this.ticketType, this.date, this.price);
}
