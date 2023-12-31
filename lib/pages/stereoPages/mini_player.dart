import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum RepeatMode { noRepeat, repeatOne, repeatAll }

class MiniPlayer extends StatefulWidget {
  final String title;
  final String artist;
  final String imageUrl;
  final String song;

  const MiniPlayer(
      {super.key, required this.title,
      required this.artist,
      required this.imageUrl,
      required this.song});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  final List<String> audioTracks = [
    'music.mp3',
    'music2.mp3',
    'music3.mp3',
    // Add more tracks as needed
  ];
  int currentTrackIndex = 0; // Initialize with the first track

  bool isPlaying = false;
  double value = 0;

  final player = AudioPlayer();

  Duration? duration = const Duration(seconds: 0);

  bool shuffle = false;

  // Function to toggle repeat mode
  RepeatMode repeat = RepeatMode.noRepeat;

  // Function to toggle repeat mode
  void toggleRepeat() {
    setState(() {
      switch (repeat) {
        case RepeatMode.noRepeat:
          repeat = RepeatMode.repeatOne;
          break;
        case RepeatMode.repeatOne:
          repeat = RepeatMode.repeatAll;
          break;
        case RepeatMode.repeatAll:
          repeat = RepeatMode.noRepeat;
          break;
      }
    });
  }

  // Function to toggle shuffle mode
  void toggleShuffle() {
    setState(() {
      shuffle = !shuffle;
      if (shuffle) {
        audioTracks.shuffle();
        currentTrackIndex = 0;
      } else {
        audioTracks.sort();
      }
      loadCurrentTrack();
    });
  }

  // Function to load the current audio track
  Future<void> loadCurrentTrack() async {
    final asset = audioTracks[currentTrackIndex];
    await player.setSource(AssetSource(asset));

    // Listen for the onDuration event to get the audio duration
    player.onDurationChanged.listen((Duration newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
  }

  void initPlayer() async {
    await player.setSource(AssetSource("music.mp3"));

    // Listen for the onDuration event to get the audio duration
    player.onDurationChanged.listen((Duration newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
    loadCurrentTrack();

    player.onPlayerComplete.listen((_) {
      setState(() {
        isPlaying = false;
      });
      playNextTrack();
    });
  }

  void playNextTrack() {
    if (currentTrackIndex < audioTracks.length - 1) {
      currentTrackIndex++;
    } else {
      if (repeat == RepeatMode.noRepeat) {
        return; // Do nothing if no repeat is selected
      } else if (repeat == RepeatMode.repeatAll) {
        currentTrackIndex = 0; // Loop back to the first track
      }
      // For repeatOne, do nothing here, and the same track will play again.
    }
    loadCurrentTrack();
    player.pause();
  }

  // Function to play the previous track
  void playPreviousTrack() {
    if (currentTrackIndex > 0) {
      currentTrackIndex--;
    } else {
      if (repeat == RepeatMode.noRepeat) {
        return; // Do nothing if no repeat is selected
      } else if (repeat == RepeatMode.repeatAll) {
        currentTrackIndex = audioTracks.length - 1; // Loop to the last track
      }
      // For repeatOne, do nothing here, and the same track will play again.
    }
    loadCurrentTrack();
    player.resume();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 95,
        // color: const Color.fromARGB(255, 52, 18, 18), // Customize the background color
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Slider.adaptive(
            //   onChanged: (v) {
            //     setState(() {
            //       value = v;
            //     });
            //     if (!isPlaying) {
            //       // If the audio is paused, change the icon to play
            //       setState(() {
            //         isPlaying = true;
            //       });
            //     }
            //   },
            //   min: 0.00,
            //   max: duration!.inSeconds.toDouble(),
            //   // value: value,
            //   value: value.clamp(
            //       0.0,
            //       duration!.inSeconds
            //           .toDouble()), // Ensure value is within the valid range
            //   onChangeEnd: (newValue) async {
            //     setState(() {
            //       value = newValue;
            //       print(value);
            //     });
            //     if (isPlaying) {
            //       if (value == duration!.inSeconds.toDouble()) {
            //         // If the slider value is at the maximum duration, handle the track completion
            //         // You can restart the track or take any other desired action
            //         // In this example, it seeks to the beginning
            //         await player.seek(const Duration(seconds: 0));
            //       } else {
            //         player.pause();
            //         await player.seek(Duration(seconds: newValue.toInt()));
            //         await player.resume();
            //       }
            //     }
            //     // You can keep the isPlaying state unchanged here since the play/pause
            //     // state is already handled when you move the slider.
            //   },
            //   activeColor: Colors.white,
            // ),
            LinearProgressIndicator(
              value: value /
                  duration!.inSeconds
                      .toDouble(), // Calculate the progress value
              valueColor: const AlwaysStoppedAnimation(
                  Color(0xFF4E0CA2)), // Customize the progress bar color
              backgroundColor: const Color(0xFFFF8A15), // Customize the background color
            ),

            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  width: 100,
                ),
              ),
              title: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.artist,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              playPreviousTrack();
                            },
                            icon: const Icon(
                              Icons.skip_previous,
                              size: 20,
                              color: Colors.black,
                            )),
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                          child: IconButton(
                            onPressed: () async {
                              if (isPlaying) {
                                await player.pause();
                              } else {
                                if (value == duration!.inSeconds.toDouble()) {
                                  // Restart from the beginning if the song has completed
                                  await player.seek(const Duration(seconds: 0));
                                }
                                await player.resume();
                              }

                              // Listen for position changes
                              player.onPositionChanged.listen((position) {
                                setState(() {
                                  value = position.inSeconds.toDouble();
                                });
                              });

                              // Update isPlaying state based on the player's state
                              final playerState = player.state;
                              setState(() {
                                isPlaying = playerState == PlayerState.playing;
                              });
                            },
                            icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 20,
                                color: Colors.white),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              playNextTrack();
                            },
                            icon: const Icon(
                              Icons.skip_next,
                              size: 20,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
