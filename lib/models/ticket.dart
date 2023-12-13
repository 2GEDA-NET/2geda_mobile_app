import 'dart:convert';

class TicketData {
  final String name;
  final String id;
  final String ticketType;
  final String date;
  final String price;

  TicketData(this.name, this.id, this.ticketType, this.date, this.price);
}

class Event {
  int id;
  List<dynamic> attendees;
  dynamic image;
  String title;
  String desc;
  String platform;
  Category category;
  DateTime date;
  Ticket ticket;
  String? location;
  dynamic url;

  Event({
    required this.id,
    required this.attendees,
    required this.image,
    required this.title,
    required this.desc,
    required this.platform,
    required this.category,
    required this.date,
    required this.ticket,
    required this.location,
    required this.url,
  });

  factory Event.fromRawJson(String str) => Event.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        attendees: List<dynamic>.from(json["attendees"].map((x) => x)),
        image: json["image"],
        title: json["title"],
        desc: json["desc"],
        platform: json["platform"],
        category: Category.fromJson(json["category"]),
        date: DateTime.parse(json["date"]),
        ticket: Ticket.fromJson(json["ticket"]),
        location: json["location"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attendees": List<dynamic>.from(attendees.map((x) => x)),
        "image": image,
        "title": title,
        "desc": desc,
        "platform": platform,
        "category": category.toJson(),
        "date": date.toIso8601String(),
        "ticket": ticket.toJson(),
        "location": location,
        "url": url,
      };
}

class Category {
  int id;
  String name;
  dynamic image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}

class Ticket {
  String category;
  int price;
  int quantity;
  bool isSold;

  Ticket({
    required this.category,
    required this.price,
    required this.quantity,
    required this.isSold,
  });

  factory Ticket.fromRawJson(String str) => Ticket.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        category: json["category"],
        price: json["price"],
        quantity: json["quantity"],
        isSold: json["is_sold"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "price": price,
        "quantity": quantity,
        "is_sold": isSold,
      };
}
