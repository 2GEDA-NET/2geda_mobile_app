import 'package:_2geda/data/business_data.dart';
import 'package:_2geda/models/business_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BusinessListWidget extends StatelessWidget {
  const BusinessListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Businesses around you', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (Business business in businesses)
                  BusinessItem(business: business),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BusinessItem extends StatelessWidget {
  final Business business;

  const BusinessItem({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(
              255, 138, 21, 1), // Set your desired background color here
          borderRadius: BorderRadius.circular(10.0), // Set the border radius
        ),
        child: Column(
          children: [
            if (business.logo != null) // Check if the business has a logo
              CachedNetworkImage(
                width: 35, // Set the desired width for the logo
                height: 35,
                imageUrl: business.logo!, // Set the desired height for the logo
              )
            else
              const Icon(Icons.business, size: 35),
            const SizedBox(width: 10),
            Text(
              business.name.length > 7
                  ? '${business.name.substring(0, 7)}...' // Take the first 7 characters and add ellipsis
                  : business
                      .name, // If the name is 7 characters or less, use the original name
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
