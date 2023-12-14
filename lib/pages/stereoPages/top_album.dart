import 'package:_2geda/data/audio_data.dart';
import 'package:_2geda/models/audio_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TopAlbum extends StatefulWidget {
  const TopAlbum({super.key});

  @override
  State<TopAlbum> createState() => _TopAlbumState();
}

class _TopAlbumState extends State<TopAlbum> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Top Album',
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
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: audioList
                        .map((audio) => buildTrackCard(audio))
                        .toList(),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: audioList
                        .map((audio) => buildTrackCard(audio))
                        .toList(),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: audioList
                        .map((audio) => buildTrackCard(audio))
                        .toList(),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: audioList
                        .map((audio) => buildTrackCard(audio))
                        .toList(),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: audioList
                        .map((audio) => buildTrackCard(audio))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTrackCard(AudioModel audio) {
    return Column(
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: 120,
                  height: 90,
                  imageUrl: audio.coverImage ?? 'default_image_url',
                ),
                CachedNetworkImage(
                  width: 110,
                  height: 100,
                  imageUrl: audio.coverImage ?? 'default_image_url',
                ),
                CachedNetworkImage(
                  width: 100,
                  height: 105,
                  imageUrl: audio.coverImage ?? 'default_image_url',
                ),
              ],
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      audio.artist,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      audio.title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(
            height: 0.5, // Set the height of the divider as needed
            color: Colors.grey, // Set the color of the divider
          ),
        ),
      ],
    );
  }

  List<Widget> buildTabButtons() {
    final tabLabels = [
      'All',
      'Afrobeats',
      'Pop',
      'Rock',
      'Country',
    ];

    return tabLabels.asMap().entries.map((entry) {
      final index = entry.key;
      final label = entry.value;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                _currentIndex == index ? const Color(0xff4f0da3) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the radius as needed
            ),
            elevation: 0,
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
      );
    }).toList();
  }
}
