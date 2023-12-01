class User {
  final String name;
  final String role;
  final String state;
  final String imageUrl;
  bool isSticked;

  User({
    required this.state, 
    required this.name,
    required this.role,
    required this.imageUrl,
    this.isSticked = false, // Initialize it as false or with the appropriate value
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      imageUrl: json['imageUrl'],
      role: json['role'],
      state: json['state'],
    );
  }
}
