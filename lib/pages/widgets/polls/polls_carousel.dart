import 'package:_2geda/pages/widgets/polls/polls_details.dart';
import 'package:_2geda/pages/widgets/polls/vote_progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PollsCard extends StatelessWidget {
  const PollsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PollDetailsPage(
              // Pass necessary data to PollDetailsPage constructor
              username: "Kayode Wills",
              timestamp: "Today @ 12:09PM",
              question: "What is your preferred programming language",
              imageUrl:
                  'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
              progress: 0.6,
              remainingDays: "2 days remaining",
              votesCount: "500 votes",
            ),
          ),
        );
      },
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(10),
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
                      imageUrl:
                          'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
                    ),
                  ),
                  title: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kayode Wills",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )),
                        Text("Today @ 12:09PM",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            )),
                      ]),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                      Text("What is your preferred programming language",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          )),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80'),
                ),
                VotingProgressBar(
                  progress: 0.6,
                  text: 'Python',
                ), // Represents 60% progress
                VotingProgressBar(
                  progress: 0.6,
                  text: 'Python',
                ), // Represents 60% progress
                VotingProgressBar(
                  progress: 0.6,
                  text: 'Python',
                ), // Represents 60% progress
                VotingProgressBar(
                  progress: 0.6,
                  text: 'Python',
                ), // Represents 60% progress
                VotingProgressBar(
                  progress: 0.6,
                  text: 'Python',
                ), // Represents 60% progress
                VotingProgressBar(
                  progress: 0.6,
                  text: 'Python',
                ), // Represents 60% progress

                const ListTile(
                  leading: Icon(Icons.watch_later),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("2 days remaining",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          )),
                      Text("500 votes",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ))
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
