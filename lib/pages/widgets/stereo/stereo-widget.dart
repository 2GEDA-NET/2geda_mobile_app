import 'package:_2geda/models/audio_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioListWidget extends StatefulWidget {
  final List<AudioModel> audioList;

  AudioListWidget({required this.audioList});

  @override
  _AudioListWidgetState createState() => _AudioListWidgetState();
}

class _AudioListWidgetState extends State<AudioListWidget> {
  int selectedIndex = -1; // Track the selected audio item index

  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        // Audio playback completed
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 180, // Adjust the height as needed
        child: Row(
          children: List.generate(widget.audioList.length, (index) {
            final audioItem = widget.audioList[index];
            final isSelected = index == selectedIndex;

            return GestureDetector(
              onTap: () {
                if (isSelected) {
                  // If the same item is tapped again, stop playback
                  audioPlayer.stop();
                  setState(() {
                    isPlaying = false;
                    selectedIndex = -1;
                  });
                } else {
                  // Play the selected audio
                  audioPlayer.play(audioItem.url
                      as Source); // Pass the URL as a String directly

                  setState(() {
                    isPlaying = true;
                    selectedIndex = index;
                  });
                }
              },
              child: Container(
                width: 170, // Adjust the width as needed
                margin: const EdgeInsets.symmetric(
                    horizontal: 0), // Add spacing between items
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: audioItem.coverImageUrl,
                            width: 150,
                            height: 125,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top:
                              45, // Adjust the top position to center vertically
                          left:
                              45, // Adjust the left position to center horizontally
                          right:
                              45, // Adjust the right position to center horizontally
                          bottom:
                              45, // Adjust the bottom position to center vertically
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the border radius as needed
                            child: Container(
                              width:
                                  50, // Adjust the width of the Container for the smaller image and its background
                              height:
                                  40, // Adjust the height of the Container for the smaller image and its background
                              color: Colors.black.withOpacity(0.4),
                              child: Center(
                                child: Image.asset(
                                  'assets/arcticons_music-party.png',
                                  width:
                                      30, // Adjust the width of the smaller image
                                  height:
                                      24, // Adjust the height of the smaller image
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(audioItem.title,
                        style: const TextStyle(
                          fontSize: 13.25,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(audioItem.artist,
                        style: const TextStyle(
                          fontSize: 9.9375,
                          fontWeight: FontWeight.w400,
                        )),
                    if (isSelected)
                      IconButton(
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        onPressed: () {
                          if (isPlaying) {
                            audioPlayer.pause();
                          } else {
                            audioPlayer.resume();
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
