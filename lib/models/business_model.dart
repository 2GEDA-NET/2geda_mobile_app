class Business {
  final String name;
  final String description;
  final String? logo; // Nullable logo property

  Business({
    required this.name,
    required this.description,
    this.logo, // Nullable logo property
  });
}
