import 'package:flutter/material.dart';

class EventCategory extends StatelessWidget {
  const EventCategory({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this list with your actual data.
    List<CategoryData> categories = [
      CategoryData("Music", 15,
          "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80"),
      CategoryData("Sports", 10,
          "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80"),
      CategoryData("Sports", 10,
          "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80"),
      CategoryData("Sports", 10,
          "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80"),
      // Add more categories here
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Event Categories",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: (categories.length / 2).ceil(),
            itemBuilder: (context, index) {
              int startIndex = index * 2;
              int endIndex = startIndex + 2;
              if (endIndex > categories.length) {
                endIndex = categories.length;
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    categories.sublist(startIndex, endIndex).map((category) {
                  return _buildEventCategoryCard(category);
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventCategoryCard(CategoryData category) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 170,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(5),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromRGBO(105, 0, 155, 0.1 * 255).withOpacity(0.1),
          ),
          child: const Icon(Icons.music_note),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center, // Align the text vertically in the center
          children: [
            Text(
              category.type,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              "${category.number} events",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}

class CategoryData {
  final String type;
  final int number;
  final String iconUrl;

  CategoryData(this.type, this.number, this.iconUrl);
}
