import 'package:_2geda/data/audio_data.dart';
import 'package:_2geda/models/audio_model.dart';
import 'package:_2geda/models/user_model.dart';
import 'package:_2geda/pages/stereoPages/album.dart';
import 'package:_2geda/pages/stereoPages/stereo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArtistProfileScreen extends StatefulWidget {
  final User user; // User object to display profile information

  const ArtistProfileScreen({super.key, required this.user});

  @override
  State<ArtistProfileScreen> createState() => _ArtistProfileScreenState();
}

class _ArtistProfileScreenState extends State<ArtistProfileScreen> {
  Color fullyTransparent = const Color.fromRGBO(79, 13, 163, 0);
  Color partialTransparent = const Color.fromRGBO(79, 13, 163, 0.2);

  LinearGradient? myLinearGradient;

  @override
  void initState() {
    super.initState();
    myLinearGradient = LinearGradient(
      colors: [fullyTransparent, partialTransparent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: myLinearGradient,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.user.username,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            width: 200, // Replace with your desired width
                            child: Text(
                              "Bella Shrmuda is an emerging indie pop sensation known for his captivating lyrics and soulful melodies. With a unique blend of nostalgia and modernity, his music speaks to the heart.",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 8,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            8), // Replace 8 with your desired border radius
                        child: CachedNetworkImage(
                          imageUrl: widget.user.userProfile!.userImage.profileImage,
                          width: 150,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Top songs",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text("View all songs",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                )),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: audioList
                        .take(4) // Take the first 4 elements
                        .map((audio) => buildTrackCard(audio))
                        .toList(),
                  ),
                  const Text("Albums",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                      const PlayList()
                ],
              ),
            )
            // You can add more user information here
          ],
        ),
      ),
    );
  }

  Widget buildTrackCard(AudioModel audio) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            width: 100,
            height: 100,
            imageUrl: audio.coverImage ?? 'default_image_url',
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    audio.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    audio.artist,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
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
    );
  }
}


class AlbumList extends StatelessWidget {
  const AlbumList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: audioList.map((audio) {
          return AlbumCard(
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
