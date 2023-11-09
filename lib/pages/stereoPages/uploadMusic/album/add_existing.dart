import 'package:_2geda/pages/stereoPages/uploadMusic/album/album_upload.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum ExistingSong { javatpoint, w3schools, tutorialandexample }

class AddExistingSong extends StatefulWidget {
  const AddExistingSong({super.key});

  @override
  State<AddExistingSong> createState() => _AddExistingSongState();
}

class _AddExistingSongState extends State<AddExistingSong> {
  ExistingSong _song = ExistingSong.javatpoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Add Existing Song',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Add existing songs",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Text(
              "Select your pre-existing songs to add to this album",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search for music',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    width: 2,
                  ),
                ),
              ),
            ),
            _musicCard(
                image:
                    "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
                title: "Dance with me",
                artist: "Faith increase",
                value: ExistingSong.javatpoint),
            _musicCard(
                image:
                    "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
                title: "Dance with me",
                artist: "Faith increase",
                value: ExistingSong.w3schools),
            _musicCard(
                image:
                    "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
                title: "Dance with me",
                artist: "Faith increase",
                value: ExistingSong.tutorialandexample),
            _musicCard(
                image:
                    "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
                title: "Dance with me",
                artist: "Faith increase",
                value: ExistingSong.tutorialandexample),
            _musicCard(
                image:
                    "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
                title: "Dance with me",
                artist: "Faith increase",
                value: ExistingSong.tutorialandexample),
            _musicCard(
                image:
                    "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
                title: "Dance with me",
                artist: "Faith increase",
                value: ExistingSong.tutorialandexample),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AlbumUpload(), // Replace with the actual screen
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xff4e0ca2), // Change background color
                  minimumSize: const Size(250, 60), // Increase width and height
                ),
                child: const Text(
                  "Add 1 track",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _musicCard(
      {required String image,
      required String title,
      required String artist,
      required ExistingSong value}) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity, // Set the width to occupy the entire screen
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 228, 224, 224),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: ClipRRect(
          child: CachedNetworkImage(
            imageUrl: image,
            width: 50.0, // Set the width as per your requirement
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  artist,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
            Radio(
              value: value,
              groupValue: _song,
              onChanged: (ExistingSong? newValue) {
                setState(() {
                  _song = newValue ?? ExistingSong.javatpoint;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
