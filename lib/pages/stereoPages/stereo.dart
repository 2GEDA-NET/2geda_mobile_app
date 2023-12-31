import 'dart:async';
import 'package:_2geda/data/audio_data.dart';
import 'package:_2geda/data/data.dart';
import 'package:_2geda/models/audio_model.dart';
import 'package:_2geda/models/user_model.dart';
import 'package:_2geda/pages/stereoPages/artist_profile.dart';
import 'package:_2geda/pages/stereoPages/big_hit_list.dart';
import 'package:_2geda/pages/stereoPages/big_hits.dart';
import 'package:_2geda/pages/stereoPages/chart.dart';
import 'package:_2geda/pages/stereoPages/library.dart';
import 'package:_2geda/pages/stereoPages/local_music.dart';
import 'package:_2geda/pages/stereoPages/mini_player.dart';
import 'package:_2geda/pages/stereoPages/stereo_search.dart';
import 'package:_2geda/pages/stereoPages/top_album.dart';
import 'package:_2geda/pages/stereoPages/trending.dart';
import 'package:_2geda/pages/stereoPages/trending_list.dart';
import 'package:_2geda/pages/stereoPages/uploadMusic/upload.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StereoScreen extends StatefulWidget {
  const StereoScreen({super.key});

  @override
  State<StereoScreen> createState() => _StereoScreenState();
}

class _StereoScreenState extends State<StereoScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  bool isMusicPlaying = false; // Add this flag to track music playback
  String currentlyPlayingTitle = ''; // Store currently playing song title
  String currentlyPlayingArtist = ''; // Store currently playing song artist
  String currentlyPlayingSong = ''; // Store currently playing song artist
  String currentlyPlayingSongImg = ''; // Store currently playing song artist

  List<User> stickiedUsers = [];
  List<User> remainingUsers = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateUserLists(); // Initial list update
    // Set up a timer to periodically update the list (every 5 seconds)
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _updateUserLists();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _updateUserLists() {
    setState(() {
      stickiedUsers = onlineUsers.where((user) => user.isSticked).toList();
      remainingUsers = onlineUsers.where((user) => !user.isSticked).toList();
    });
  }

  void updateStickiedUsers(User user) {
    setState(() {
      if (stickiedUsers.contains(user)) {
        stickiedUsers.remove(user);
        remainingUsers.add(user);
      } else {
        if (stickiedUsers.length < 4) {
          stickiedUsers.add(user);
          remainingUsers.remove(user);
        }
      }
      user.isSticked = !user.isSticked;
    });
  }

  // Function to update mini-player state
  void updateMiniPlayerState(
      {required bool isPlaying,
      required String title,
      required String artist,
      required String song,
      required String imageUrl}) {
    setState(() {
      isMusicPlaying = isPlaying;
      currentlyPlayingTitle = title;
      currentlyPlayingArtist = artist;
      currentlyPlayingSong = song;
      currentlyPlayingSongImg = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/2geda-purple.png',
            width: 40,
            height: 40,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 80,
        title: const Text(
          'Stereo',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle the search action
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StereoSearchScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.music_note),
            onPressed: () {
              // Handle the notifications action
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LibraryScreen(),
                ),
              );
            },
          ),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text("Trending",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Trending(),
                                  ),
                                );
                              },
                              child: const Row(
                                children: [
                                  Text("More",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 10,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const TrendingMusicList(),
                        Image.asset("assets/banner2.png"),
                        Row(
                          children: [
                            const Text("Today’s big hits",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BigHits(),
                                  ),
                                );
                              },
                              child: const Row(
                                children: [
                                  Text("More",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 10,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const BigHitMusicList(),
                        Row(
                          children: [
                            const Text("Top albums",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TopAlbum(),
                                  ),
                                );
                              },
                              child: const Row(
                                children: [
                                  Text("More",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 10,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const MusicList(),
                        const Text("Special picks for you",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        const MusicList(),
                        Image.asset("assets/banner2.png")
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Adrican Vibe",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        const PlayList(),
                        const Text("Best of Afrobeats",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        const PlayList(),
                        const Text("Recommended",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        const PlayList(),
                        const Text("Pop for you",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        const PlayList(),
                        const Text("Special picks for you",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        const PlayList(),
                        Image.asset('assets/banner2.png'),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("New release",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      const AlbumList(),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text("New albums",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      const AlbumList(),
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset("assets/banner2.png")
                    ],
                  ),
                )),
                const SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [LocalMusicCardList()],
                  ),
                )),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: audioList
                            .map((audio) => buildTrackCard(audio))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const ChartGridList(), // Create an instance of ChartGridList
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/banner2.png"),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.search), // Icon as a prefix
                          hintText: 'Find artist', // Placeholder text
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Adjust the radius as needed
                            borderSide: const BorderSide(
                              width: 2, // Set the border width
                            ),
                          ),
                        ),
                        // Add any other properties and handlers as needed
                      ),
                      artistList(),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add the functionality you want when the FAB is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UploadMusicScreen(),
            ),
          );
        },
        child: const Icon(Icons.add), // You can use any icon you prefer
      ),
      bottomNavigationBar: isMusicPlaying
          ? MiniPlayer(
              title: currentlyPlayingTitle,
              artist: currentlyPlayingArtist,
              song: currentlyPlayingSong,
              imageUrl: currentlyPlayingSongImg,
            ) // Show the mini-player if music is playing
          : null, // Hide it otherwise
    );
  }

  Widget artistList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            for (User user in stickiedUsers)
              _buildUserRow(user, updateStickiedUsers),
            for (User user in remainingUsers)
              _buildUserRow(user, updateStickiedUsers),
          ],
        ),
      ],
    );
  }

  Widget _buildUserRow(User user, Function(User) onStickied) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArtistProfileScreen(user: user),
          ),
        );
      },
      child: Column(
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.network(
                  user.userProfile!.userImage.profileImage,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.username,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      )),
                  // Text(
                  //   user.role,
                  //   style: const TextStyle(
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.w400,
                  //       color: Color.fromARGB(255, 106, 105, 105)),
                  // ),
                  // Text(
                  //   user.state,
                  //   style: const TextStyle(
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.w400,
                  //       color: Colors.grey),
                  // ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  onStickied(user);
                },
                child: Text(user.isSticked ? 'Sticking' : 'Stick'),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildTrackCard(AudioModel audio) {
    return Column(
      children: [
        Container(
          child: ListTile(
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
      'Home',
      'Explore',
      'New',
      'Local music',
      'Top tracks',
      'Charts',
      'Artists'
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

class MusicList extends StatelessWidget {
  const MusicList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: audioList.map((audio) {
          return MusicCard(
            title: audio.title,
            artist: audio.artist,
            imageUrl: audio.coverImage ?? 'default_image_url',
            url: audio.audioFile,
          );
        }).toList(),
      ),
    );
  }
}

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: audioList.map((audio) {
          return PlayListCard(
            title: audio.title,
            artist: audio.artist,
            imageUrl: audio.coverImage ?? 'default_image_url',
            url: audio.audioFile,
          );
        }).toList(),
      ),
    );
  }
}

class MusicCard extends StatelessWidget {
  final String title;
  final String artist;
  final String imageUrl;
  final String url;

  const MusicCard(
      {super.key,
      required this.title,
      required this.artist,
      required this.url,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Update the mini-player state by calling the method from _StereoScreenState
                      (context as Element)
                          .markNeedsBuild(); // Force rebuild to update the mini-player
                      context
                          .findAncestorStateOfType<_StereoScreenState>()
                          ?.updateMiniPlayerState(
                            isPlaying: true,
                            title: title,
                            artist: artist,
                            imageUrl: imageUrl,
                            song: url,
                          );
                      // Add your play functionality here
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(171, 210, 204, 204),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title.length > 10 ? '${title.substring(0, 10)}...' : title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    artist.length > 10
                        ? '${artist.substring(0, 10)}...'
                        : artist,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  // Add your play functionality here

                  // Update the mini-player state when the play button is pressed
                  // Assuming you have a function to play the song
                  // Call updateMiniPlayerState with the relevant information
                  (context as Element)
                      .markNeedsBuild(); // Force rebuild to update the mini-player
                  context
                      .findAncestorStateOfType<_StereoScreenState>()
                      ?.updateMiniPlayerState(
                        isPlaying: true,
                        title: title,
                        artist: artist,
                        song: url,
                        imageUrl: imageUrl,
                      );
                  // Add your play functionality here
                },
                icon: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF9E69D2),
                  ),
                  child: const Icon(Icons.play_arrow),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PlayListCard extends StatelessWidget {
  final String title;
  final String artist;
  final String imageUrl;
  final String url;

  const PlayListCard(
      {super.key,
      required this.title,
      required this.artist,
      required this.url,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 150,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(title,
              style: const TextStyle(
                fontSize: 10.656488418579102,
                fontWeight: FontWeight.w400,
              )),
        ],
      ),
    );
  }
}


class LocalMusicCard extends StatelessWidget {
  final String title;
  final String artist;
  final String url;
  final String imageUrl;

  const LocalMusicCard({
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
        (context as Element)
            .markNeedsBuild(); // Force rebuild to update the mini-player
        context
            .findAncestorStateOfType<_StereoScreenState>()
            ?.updateMiniPlayerState(
              isPlaying: true,
              title: title,
              artist: artist,
              song: url,
              imageUrl: imageUrl,
            );
        // Add your play functionality here
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(
                  height: 5,
                ),
                Text(artist,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )),
              ],
            ),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
      ),
    );
  }
}
