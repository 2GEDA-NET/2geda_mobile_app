import 'package:_2geda/models/movie_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class StackedCardCarousel extends StatelessWidget {
  final List<Movie> movies;

  const StackedCardCarousel({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: CarouselSlider.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return StackedMovieCard(movie: movies[index]);
        },
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          autoPlay: false,
          enlargeCenterPage: true, // Disable center page enlargement
          enableInfiniteScroll: true,
          viewportFraction: 0.7, // Adjust this value for overlap
          height: 250, // Adjust the itemHeight to control vertical spacing
          initialPage: 2, // Adjust the initial page to control overlap
        ),
      ),
    );
  }
}

class StackedMovieCard extends StatelessWidget {
  final Movie movie;

  const StackedMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    const cardHeight = 250.0; // Adjust the card height as needed
    const borderRadius = 10.0; // Adjust the border radius as needed

    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      margin: const EdgeInsets.all(
          0.00000009), // Adjust the margin to control the gap
      child: SizedBox(
        width: double.infinity, // Set the width to match the card's width
        child: ClipRRect(
          // Use ClipRRect to round the corners
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            children: [
              Container(
                height: cardHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(movie.imageUrl),
                    fit: BoxFit
                        .cover, // Use BoxFit.cover to cover the whole card
                  ),
                ),
              ),
              // Overlay for better text visibility
              Container(
                height: cardHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(
                      0.5), // Adjust the opacity and color as needed
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Set the shape to a circle
                    color: const Color(0xff4e0ca2).withOpacity(
                        0.5), // Adjust the opacity and color as needed
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment
                    .bottomLeft, // Align text to the bottom left corner
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle, // Set the shape to a circle
                    color: Colors.black.withOpacity(
                        0.5), // Adjust the opacity and color as needed
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Year (${movie.year})',
                            style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.more_vert,
                        color: Colors.white, // Set the icon color to white
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
