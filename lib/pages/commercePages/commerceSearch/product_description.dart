import 'package:_2geda/models/product_model.dart';
import 'package:_2geda/pages/widgets/product/product_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDescription extends StatefulWidget {
  final Product product;

  const ProductDescription({super.key, required this.product});

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Product Information',
          style: TextStyle(color: Color(0xff4e0ca2)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: widget.product.image,
                fit: BoxFit.cover,
                height: 235,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color(0xff4e0ca2),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.category.name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '\$ ${widget.product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Sale Location : ${widget.product.location}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.product.image,
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 150,
                      child: const Text(
                          "Newly used Toyota venza | V6 engine | Full option Custom duty and Fully registered. Average speed 245km/sec, Auto and Manual transmission for Sport mode.",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff4e0ca2),
                          minimumSize: const Size(180, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Edit info",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF0000),
                          minimumSize: const Size(180, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Delete product",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ReviewWidget(
                rating: widget.product.rating,
                review: widget.product.reviews,
              ),
              AddReviewWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  final double rating; // Rating out of 5
  final int review;
  final double maxRating = 5; // Maximum rating

  const ReviewWidget({Key? key, required this.rating, required this.review})
      : super(key: key);

  // Method to create a row with a rating and progress bar
  Widget _buildRatingRow(int starRating, double progressValue) {
    return Row(
      children: [
        Text(
          starRating.toString(),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Icon(
          Icons.star,
          size: 16,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(5), // Adjust the radius as needed
            child: LinearProgressIndicator(
              minHeight: 7,
              value: progressValue,
              backgroundColor: const Color(0xffd9d9d9),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xfff96969)),
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          '60%', // You can customize this as needed
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Reviews($review)",
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            for (int i = 0; i < maxRating; i++)
              Icon(
                i < rating ? Icons.star : Icons.star_border,
                color: i < rating ? const Color(0xfff96969) : Colors.grey,
              ),
            Text(
              '$rating/ $maxRating',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Create rows with ratings and progress bars for each star rating
        for (int i = 5; i >= 1; i--)
          Column(
            children: [
              _buildRatingRow(i, rating / maxRating - (5 - i)),
              const SizedBox(height: 10),
            ],
          ),
      ],
    );
  }
}

class AddReviewWidget extends StatefulWidget {
  @override
  _AddReviewWidgetState createState() => _AddReviewWidgetState();
}

class _AddReviewWidgetState extends State<AddReviewWidget> {
  double rating = 0.0;
  String reviewText = '';

  void _submitReview() {
    // You can implement the logic to submit the review here
    print('Rating: $rating');
    print('Review Text: $reviewText');
    // You can send this data to your backend or handle it as needed.
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("Add a review",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: 'Write your review here',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  8.0), // Adjust the border radius as needed
            ),
          ),
          maxLines: 4,
          onChanged: (text) {
            setState(() {
              reviewText = text;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RatingBar(
              initialRating: rating,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              ratingWidget: RatingWidget(
                full: const Icon(Icons.star, color: Colors.amber),
                half: const Icon(Icons.star_half, color: Colors.amber),
                empty: const Icon(Icons.star_border, color: Colors.amber),
              ),
              itemSize: 30.0,
              onRatingUpdate: (newRating) {
                setState(() {
                  rating = newRating;
                });
              },
            ),
            ElevatedButton(
              onPressed: _submitReview,
              child: const Text(
                "Post comment",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Image.asset(
          'assets/banner.png',
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: List.generate(9, (index) {
                return buildReviewItem(
                    'Sam Loco', '“Good customer services always”', rating);
              }),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Similar items",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const ProductListWidget()
      ],
    );
  }

  Widget buildReviewItem(String name, String reviewText, double rating) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  reviewText,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.star),
                Text(
                  rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
