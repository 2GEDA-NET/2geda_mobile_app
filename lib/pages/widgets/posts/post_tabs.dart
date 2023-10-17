import 'package:flutter/material.dart';



List<Widget> buildTabButtons({
  required List<String> tabLabels,
  required int currentIndex,
  required Function(int) onTabPressed,
}) {
  return [
    Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black, // Set the top border color
            width: 0.2, // Set the top border width
          ),
          bottom: BorderSide(
            color: Colors.black, // Set the bottom border color
            width: 0.2, // Set the bottom border width
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: tabLabels.asMap().entries.map((entry) {
            final index = entry.key;
            final label = entry.value;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentIndex == index ? const Color(0xff4f0da3) : Colors.white,
                  elevation: 0, // Remove elevation
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  onTabPressed(index); // Notify the parent widget about the tab change
                },
                child: Text(
                  label,
                  style: TextStyle(
                    color: currentIndex == index ? Colors.white : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ),
  ];
}
