import 'package:flutter/material.dart';

class ArtistOverviewCard extends StatelessWidget {
  final String count;
  final String text;
  const ArtistOverviewCard(
      {super.key, required this.count, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 227, 225, 225),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(count,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(
              height: 10,
            ),
            Text(text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4E0CA2),
                )),
          ],
        ),
      ),
    );
  }
}
