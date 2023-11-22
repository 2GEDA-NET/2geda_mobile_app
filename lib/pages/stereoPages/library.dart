import 'package:_2geda/data/audio_data.dart';
import 'package:_2geda/pages/stereoPages/album.dart';
import 'package:_2geda/pages/stereoPages/stereo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Library',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            // color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buildTabButtons(),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: const [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      PlaylistGridList(),
                      ArtistGridList(),
                      AlbumGridList(),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      PlaylistGridList(),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      AlbumGridList(),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ArtistGridList(),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      PlaylistGridList(),
                      AlbumGridList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            "assets/banner2.png",
            width:
                MediaQuery.of(context).size.width, // Set width to screen width
            height: 42,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  List<Widget> buildTabButtons() {
    final tabLabels = ['All', 'Playlists', 'Albums', 'Artist', 'Downloaded'];

    return tabLabels.asMap().entries.map((entry) {
      final index = entry.key;
      final label = entry.value;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _currentIndex == index
                    ? const Color(0xff4f0da3)
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      20.0), // Adjust the radius as needed
                ),
              ),
              onPressed: () {
                // Update the PageView when a tab button is pressed
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                label,
                style: TextStyle(
                  color: _currentIndex == index ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}

class PlaylistGridList extends StatelessWidget {
  const PlaylistGridList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemCount: chartList.length,
            itemBuilder: (BuildContext context, int index) {
              return PlayListCard(
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

class AlbumGridList extends StatelessWidget {
  const AlbumGridList({Key? key}) : super(key: key);

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
              return AlbumCard(
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

class ArtistGridList extends StatelessWidget {
  const ArtistGridList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: chartList.length,
            itemBuilder: (BuildContext context, int index) {
              return ArtistCard(
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

class ArtistCard extends StatelessWidget {
  final String title;
  final String artist;
  final String imageUrl;
  final String url;

  const ArtistCard(
      {super.key,
      required this.title,
      required this.artist,
      required this.url,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width:
              100, // Adjust the width and height to set the size of the circular avatar
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl),
              fit: BoxFit
                  .cover, // You can adjust the fit to control how the image is displayed
            ),
          ),
        ),
        Text(artist,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ))
      ],
    );
  }
}
