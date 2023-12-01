import 'package:_2geda/pages/widgets/polls/vote_progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PollDetailsPage extends StatelessWidget {
  final String username;
  final String timestamp;
  final String question;
  final String imageUrl;
  final double progress;
  final String remainingDays;
  final String votesCount;

  const PollDetailsPage({
    Key? key,
    required this.username,
    required this.timestamp,
    required this.question,
    required this.imageUrl,
    required this.progress,
    required this.remainingDays,
    required this.votesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Build your details page using the passed data
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Post Details',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: ClipOval(
                  child: CachedNetworkImage(
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    imageUrl: imageUrl,
                  ),
                ),
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(username,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                      Text(timestamp,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          )),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(question,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )),
              ),
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(imageUrl: imageUrl),
              ),
              VotingProgressBar(
                progress: progress,
                text: 'Python',
              ), // Represents 60% progress
        
              ListTile(
                leading: const Icon(Icons.watch_later),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(remainingDays,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                    Text(votesCount,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                ),
              ),
        
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 138, 21, 1),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Text("You have 10 votes",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/banner2.png"),
              ),
            ]),
      ),
    );
  }
}
