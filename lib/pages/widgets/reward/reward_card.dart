import 'package:flutter/material.dart';

class RewardData {
  final String title;
  final String subtitle;
  final String coinNumber;
  final IconData icon;
  final int currentCount;
  final int totalCount;

  RewardData({
    required this.title,
    required this.subtitle,
    required this.coinNumber,
    required this.icon,
    required this.currentCount,
    required this.totalCount,
  });
}

class RewardCard extends StatelessWidget {
  final RewardData rewardData;

  const RewardCard({Key? key, required this.rewardData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(rewardData.icon)),
              title: Row(
                children: [
                  Text(rewardData.title),
                  const SizedBox(width: 5),
                  Image.asset(
                    "assets/ooni_coin.png",
                    width: 12,
                    height: 12,
                  ),
                  Text(
                    rewardData.coinNumber,
                    style: TextStyle(color: Color(0xFFDABD79)),
                  ),
                ],
              ),
              subtitle: Text(rewardData.subtitle),
              trailing: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  rewardData.currentCount == rewardData.totalCount
                      ? "Claim"
                      : "Continue",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xff4e0ca2)),
              value: rewardData.currentCount / rewardData.totalCount,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 10),
                Text(
                  '${rewardData.currentCount}/${rewardData.totalCount}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
