import 'package:_2geda/pages/votingPages/cast_vote.dart';
import 'package:_2geda/pages/votingPages/create_poll.dart';
import 'package:_2geda/pages/votingPages/my_polls.dart';
import 'package:flutter/material.dart';

class VotingScreen extends StatelessWidget {
  const VotingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          ),
          title: const Text(
            'Voting',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Hello Tyler Miles,",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              const Text("What you want to do today?",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  )),
              const SizedBox(
                height: 10,
              ),
              Image.asset("assets/banner2.png"),
              const SizedBox(
                height: 10,
              ),
              containerButton(
                  Icons.poll,
                  "Create poll",
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(208, 213, 221, 1),
                    ),
                    child: Stack(
                      children: [
                        const Icon(
                          Icons.notifications,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF4E0CA2)),
                              child: const Text("3",
                                  style: TextStyle(
                                      fontSize: 6,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white))),
                        ),
                      ],
                    ),
                  ), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyPollScreen(),
                  ),
                );
              }),
              const SizedBox(
                height: 10,
              ),
              containerButton(
                  Icons.how_to_vote,
                  "Cast Vote",
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(255, 138, 21, 1),
                    ),
                    child: const Text(
                      "25 new polls",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CastVoteScreen(),
                  ),
                );
              }),
            ],
          ),
        ));
  }

  Widget containerButton(icon, text, subWidget, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey, // Choose your border color
            width: 1.0, // Choose your border width
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: ListTile(
          leading: Icon(icon),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subWidget,
            ],
          ),
        ),
      ),
    );
  }
}
