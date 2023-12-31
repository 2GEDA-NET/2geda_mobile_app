// account_screen.dart

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';

enum RepeatMode { noRepeat, repeatOne, repeatAll }

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
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

  LinearGradient gradient = const LinearGradient(
      begin: Alignment.topCenter, // Start from the top
      end: Alignment.bottomCenter, // End at the bottom
      colors: [
        Color.fromRGBO(79, 13, 163, 1), // First color
        Color.fromRGBO(97, 26, 148, 1), // Second color
        Color.fromRGBO(255, 138, 21, 1), // Third color (at the bottom)
      ],
      stops: [0.0, 0.5, 1.0], // Stops for each color (0.0 - 1.0)
      transform: GradientRotation(pi / 30.0));

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

  // Function to play the next track
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_down, // Change this to the desired icon
            color: Colors.black, // Change the icon color if needed
          ),
          onPressed: () {
            // Handle the back button press
          },
        ),
        toolbarHeight: 70,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Column(
          children: [
            Text(
              'FROM THE ALBUM',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text("Sunset",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ))
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/stereo.png',
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Life to the keys",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              )),
                          Text("Cross Marley",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ))
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.download))
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                gradient: gradient,
              ),
              child: Column(
                children: [
                  Slider.adaptive(
                    onChanged: (v) {
                      setState(() {
                        value = v;
                      });
                      if (!isPlaying) {
                        // If the audio is paused, change the icon to play
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    },
                    min: 0.00,
                    max: duration!.inSeconds.toDouble(),
                    // value: value,
                    value: value.clamp(
                        0.0,
                        duration!.inSeconds
                            .toDouble()), // Ensure value is within the valid range
                    onChangeEnd: (newValue) async {
                      setState(() {
                        value = newValue;
                        print(value);
                      });
                      if (isPlaying) {
                        if (value == duration!.inSeconds.toDouble()) {
                          // If the slider value is at the maximum duration, handle the track completion
                          // You can restart the track or take any other desired action
                          // In this example, it seeks to the beginning
                          await player.seek(const Duration(seconds: 0));
                        } else {
                          player.pause();
                          await player.seek(Duration(seconds: newValue.toInt()));
                          await player.resume();
                        }
                      }
                      // You can keep the isPlaying state unchanged here since the play/pause
                      // state is already handled when you move the slider.
                    },
                    activeColor: Colors.white,
                  ),
                  Row(
                    children: [
                      Text("${(value / 60).floor()} : ${(value % 60).floor()}",
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                      const Spacer(),
                      Text(
                        "${duration!.inMinutes} : ${duration!.inSeconds % 60}",
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          toggleRepeat();
                        },
                        icon: Icon(
                          Icons.repeat,
                          size: 35,
                          color: repeat != RepeatMode.noRepeat
                              ? Colors.white
                              : Colors
                                  .grey, // Adjust the color based on the repeat mode
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            playPreviousTrack();
                          },
                          icon: const Icon(
                            Icons.skip_previous,
                            size: 40,
                            color: Colors.white,
                          )),
                      // Container(
                      //   width: 70,
                      //   height: 70,
                      //   decoration: const BoxDecoration(
                      //       shape: BoxShape.circle, color: Colors.white),
                      //   child: IconButton(
                      //     onPressed: () async {
                      //       if (isPlaying) {
                      //         await player.pause();
                      //       } else {
                      //         if (value == duration!.inSeconds.toDouble()) {
                      //           // Restart from the beginning if the song has completed
                      //           await player.seek(Duration(seconds: 0));
                      //         }
                      //         await player.resume();
                      //       }
      
                      //       // Update isPlaying state based on the player's state
                      //       final playerState = await player.state;
                      //       setState(() {
                      //         isPlaying = playerState == PlayerState.playing;
                      //       });
      
                      //       setState(() {
                      //         isPlaying =
                      //             !isPlaying; // Toggle the play/pause state
                      //       });
      
                      //       player.onPositionChanged.listen((position) {
                      //         setState(() {
                      //           value = position.inSeconds.toDouble();
                      //         });
                      //       });
      
                      //     },
                      //     icon: Icon(
                      //       isPlaying ? Icons.pause : Icons.play_arrow,
                      //       size: 40,
                      //       color: Color(0xff4e0ca2),
                      //     ),
                      //   ),
                      // ),
      
                      Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
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
                            size: 40,
                            color: const Color(0xff4e0ca2),
                          ),
                        ),
                      ),
      
                      IconButton(
                          onPressed: () {
                            playNextTrack();
                          },
                          icon: const Icon(
                            Icons.skip_next,
                            size: 40,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share,
                            size: 35,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: Colors.black),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("About artist",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
                          width: 40, // Adjust the size as needed
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Column(
                        children: [
                          Text("Cross Marley",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                          SizedBox(
                            height: 5,
                          ),
                          Text("209,980 stickers",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      "Cross Marley's music effortlessly blends reggae and hip-hop, creating a captivating and authentic sound that resonates with listeners worldwide.",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: Colors.white
                      ))
                ],
              ),
            ),
            Image.asset('assets/banner2.png')
          ],
        ),
      ),
    );
  }
}
