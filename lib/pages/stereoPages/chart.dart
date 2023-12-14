
import 'package:_2geda/data/audio_data.dart';
import 'package:_2geda/pages/stereoPages/chart_details.dart';
import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
  final String title;
  final String artist;
  final String url;
  final String imageUrl;

  const ChartCard({
    super.key,
    required this.title,
    required this.artist,
    required this.url,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChartCardDetail(
              title: title,
              artist: artist,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imageUrl,
            ),
          ),
          const Text("Top 100 new release",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              )),
          const Text("100 songs",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ))
        ],
      ),
    );
  }
}

class ChartGridList extends StatelessWidget {
  const ChartGridList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: chartList.length,
            itemBuilder: (BuildContext context, int index) {
              return ChartCard(
                title: chartList[index].title,
                artist: chartList[index].artist,
                url: chartList[index].url,
                imageUrl: chartList[index].imageUrl,
              );
            },
            shrinkWrap: true, // Allow the GridView to scroll inside the Column
            physics:
                const NeverScrollableScrollPhysics(), // Disable GridView scrolling
          ),
        ],
      ),
    );
  }
}
