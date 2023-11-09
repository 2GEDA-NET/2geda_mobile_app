

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PromotionCard extends StatelessWidget {
  const PromotionCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your gradient colors
    List<Color> colors = [
      const Color(0xFF4E0CA2),
      const Color.fromARGB(255, 255, 255, 255)
    ]; // Replace with your desired colors

// Define your 'from' and 'to' positions for the gradient
    AlignmentGeometry from = Alignment.topCenter;
    AlignmentGeometry to = Alignment.bottomCenter;
    return Card(
        elevation: 10,
        child: Container(
          width: 150,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              begin: from,
              end: to,
              colors: colors,
            ),
          ),
          child: Column(
            children: [
              const Text("Now on 2geda stereo",
                  style: TextStyle(
                      fontSize: 6,
                      fontWeight: FontWeight.w300,
                      color: Colors.white)),
              const SizedBox(
                height: 5,
              ),
              Stack(alignment: Alignment.topCenter, children: [
                CachedNetworkImage(
                  imageUrl:
                      "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
                  height: 120,
                  width: 80,
                ),
                CachedNetworkImage(
                  imageUrl:
                      "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
                  height: 130,
                  width: 90,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
                      height: 150,
                      width: 100,
                    ),
                    Image.asset(
                      "assets/2geda-purple.png",
                      width: 30,
                    )
                  ],
                ),
              ]),
              const Text("Dance with me",
                  style: TextStyle(
                    fontSize: 7,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                height: 5,
              ),
              const Text("Faithincrease",
                  style: TextStyle(
                    fontSize: 6,
                    fontWeight: FontWeight.w300,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/2geda-purple.png",
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              )
            ],
          ),
        ));
  }
}

