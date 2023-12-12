import 'package:_2geda/pages/stereoPages/uploadMusic/single/share_upload.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UploadDetailsCard extends StatelessWidget {
  const UploadDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 225, 223, 223),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          ListTile(
            leading: CachedNetworkImage(
              imageUrl:
                  'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
              width: 50,
              height: 50,
            ),
            title: Row(
              children: [
                const Column(
                  children: [
                    Text(
                      "Dance with me",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Faith increase",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      _showPostOptionsDialog(context);
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          const Divider(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("2.4K",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Plays",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4E0CA2)))
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text("1.9k",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Likes",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4E0CA2)))
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text("5",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Playlist entries",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4E0CA2)))
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text("100",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Downloads",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4E0CA2)))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  void _showPostOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(20),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Delete()),
                // );
              },
              child: const Row(
                children: [

                  Icon(Icons.delete),
                  SizedBox(width: 10,),
                  Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            SimpleDialogOption(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShareUpload()),
                );
              },
              child: const Row(
                children: [
                  Icon(Icons.rocket_launch),
                  SizedBox(width: 10,),
                  Text(
                    "Promote",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            SimpleDialogOption(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShareUpload()),
                );
              },
              child: const Row(
                children: [
                  Icon(Icons.share),
                  SizedBox(width: 10,),
                  Text(
                    "Share",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            
          ],
        );
      },
    ).then((result) {
      // Handle the selected option here if needed
      if (result != null) {
        print("Selected Option: $result");
        // You can perform an action based on the selected option.
      }
    });
  }
}
