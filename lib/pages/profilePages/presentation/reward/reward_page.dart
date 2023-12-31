import 'dart:math';

import 'package:_2geda/data/reward_data.dart';
import 'package:_2geda/pages/profilePages/presentation/reward/more_rewards.dart';
import 'package:_2geda/pages/profilePages/presentation/reward/referral/referral.dart';
import 'package:_2geda/pages/profilePages/presentation/reward/referral/withdraw.dart';
import 'package:_2geda/pages/profilePages/presentation/reward/reward_history.dart';
import 'package:_2geda/pages/widgets/reward/reward_card.dart';
import 'package:flutter/material.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: const Text(
              'Rewards',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: const Color(0xFF4E0CA2),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/2geda-logo.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ]),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(color: Color(0xFF4E0CA2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Balance",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RewardHistory(),
                            ),
                          );
                        },
                        child: const Text("View history",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset("assets/ooni_coin.png"),
                      const Text("0.00",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFDABD79))),
                    ],
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WithDrawScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Add border radius
                          ),
                        ),
                        child: const Text("Request withdrawal",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Rewards",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MoreRewards(),
                            ),
                          );
                        },
                        child: const Text("View more",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView.builder(
                      itemCount:
                          min(5, rewardList.length), // Display at most 5 items
                      // itemCount: rewardList.length,
                      itemBuilder: (context, index) {
                        return RewardCard(rewardData: rewardList[index]);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: const Color(0xFF4E0CA2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Refer and Earn",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              const Text("Refer friends, earn rewards.",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white)),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ReferralPage(),
                                      ),
                                    );
                                  },
                                  child: const Text("Start earning",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      )))
                            ],
                          ),
                          Image.asset("assets/pana.png")
                        ]),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
