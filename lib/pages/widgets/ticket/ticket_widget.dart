import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TicketWidget extends StatelessWidget {
  final String coverImageUrl;
  final String title;
  final String date;
  final String location;

  const TicketWidget({
    Key? key,
    required this.coverImageUrl,
    required this.title,
    required this.date,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 2,
      shadowColor: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: CachedNetworkImage(
                  width:
                      250, // Set the image width to match the container width
                  height: 150,
                  fit: BoxFit.cover,
                  imageUrl: coverImageUrl,
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Container(
                  width: 250,
                  height: 150,
                  color: Colors.black
                      .withOpacity(0.5), // Adjust the opacity as needed
                ),
              ),
              Positioned(
                top: 2, // Adjust the top position as needed
                left: 0, // Adjust the left position as needed
                right: 0, // Adjust the right position as needed
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xff4e0ca2),
                        borderRadius: BorderRadius.circular(
                            7.0), // Adjust the radius as needed
                      ),
                      child: const Text(
                        'Live Event',
                        style: TextStyle(
                          color: Colors
                              .white, // Set text color to white or another contrasting color
                        ),
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/2geda-logo.png',
                      width: 40,
                      height: 40,
                    ), // Replace 'second-image.png' with your second image asset
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              '$date - $location',
              style: const TextStyle(
                fontSize: 14, // You can adjust the font size as needed
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          ElevatedButton(
            onPressed: () {
              // Add action when the "Get Ticket" button is pressed
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(
                  0xff4e0ca2), // Set the button background color to purple
            ),
            child: const Text(
              "Get Ticket",
              style: TextStyle(
                color: Colors.white, // Set the text color to white
              ),
            ),
          ),
          const SizedBox(height: 5.0),
        ],
      ),
    );
  }
}
