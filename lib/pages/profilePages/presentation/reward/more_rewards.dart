import 'package:_2geda/data/reward_data.dart';
import 'package:_2geda/pages/widgets/reward/reward_card.dart';
import 'package:flutter/material.dart';

class MoreRewards extends StatelessWidget {
  const MoreRewards({super.key});

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
                )),
            title: const Text(
              'Rewards',
            ),
            centerTitle: true,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/2geda-purple.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: ListView.builder(
                    itemCount: rewardList.length,
                    itemBuilder: (context, index) {
                      return RewardCard(rewardData: rewardList[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
