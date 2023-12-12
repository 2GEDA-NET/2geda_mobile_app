class Business {
  final String name;
  final String description;
  final String address;
  final String? logo; // Nullable logo property

  Business({
    required this.address,
    required this.name,
    required this.description,
    this.logo, // Nullable logo property
  });
}
