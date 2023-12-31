import 'package:_2geda/pages/widgets/product/product_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TopProductsTab extends StatelessWidget {
  const TopProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Video Banner
        Padding(
          padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set the desired width of the image
                height: 100, // Set the desired height of the image
                child: CachedNetworkImage(
                  imageUrl:
                      'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
                  fit: BoxFit.cover,
                ),
              ),
              const Icon(
                Icons.play_arrow,
                size: 48, // Set the desired size of the play icon
                color: Colors.white, // Set the desired color of the play icon
              ),
            ],
          ),
        ),

        // ignore: prefer_const_constructors
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            "Trending sales",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: ProductListWidget(),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text(
                "Best selling",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "View all",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: ProductListWidget(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/banner.png'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text(
                "Top rated",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "View all",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),

        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: ProductListWidget(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/banner3.png'),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text(
                "Listed near you",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "View all",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),

        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: ProductListWidget(),
        ),
      ],
    );
  }
}
