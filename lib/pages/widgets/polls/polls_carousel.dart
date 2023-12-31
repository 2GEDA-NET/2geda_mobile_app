
import 'package:_2geda/pages/votingPages/presentation/poll_result.dart';
import 'package:_2geda/pages/widgets/polls/polls_details.dart';
import 'package:_2geda/pages/widgets/polls/vote_progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyPollsCard extends StatelessWidget {
  const MyPollsCard({super.key});

  // Function to open the dialog
  void _openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Close poll?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          content: const Text(
              "This poll will not be made available anymore and would be marked as ended. Are you sure you want to close this poll?",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.red), // Replace with your desired color
              ),
              child: const Text("Close poll",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white)),
            )
          ],
        );
      },
    );
  }

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
              votesCount: 500, optionContent: '', selectedOption: null,
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
                  child: Text("What is your preferred programming language",
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
                const VotingProgressBar(
                  progress: 0.6,
                  text: 'Python',
                ), // Represents 60% progress
                const VotingProgressBar(
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
                ),

                const SizedBox(
                  height: 10,
                ),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.remove_red_eye),
                              Text("24.5k",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ],
                          ),
                          Text("views",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.how_to_vote),
                              Text("24.5k",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ],
                          ),
                          Text("votes",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PollResultScreen(
                                username: "Kayode Wills",
                                timestamp: "Today @ 12:09PM",
                                question:
                                    "What is your preferred programming language",
                                imageUrl:
                                    'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
                                progress: 0.6,
                                remainingDays: "2 days remaining",
                                votesCount: 500,
                                optionContent: '',
                                selectedOption: null,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          minimumSize: const Size(80, 40),
                        ),
                        child: const Text("View result",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white))),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _openDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(208, 213, 221, 1),
                          minimumSize: const Size(80, 40),
                        ),
                        child: const Text("Close poll",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ))),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
