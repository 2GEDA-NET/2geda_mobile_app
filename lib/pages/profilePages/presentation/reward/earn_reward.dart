
import 'package:_2geda/pages/profilePages/presentation/reward/reward_page.dart';
import 'package:flutter/material.dart';

class EarnReward extends StatefulWidget {
  const EarnReward({super.key});

  @override
  State<EarnReward> createState() => _EarnRewardState();
}

class _EarnRewardState extends State<EarnReward> {
  String selectedCoin = ''; // Track the selected coin

  void _onCoinSelected(String coinName) {
    setState(() {
      selectedCoin = coinName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Before you continue,",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Text("Select a default currency",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _rewardButtonCoin(
                      context,
                      "assets/ooniMed.png",
                      "Ooni Coin",
                      "ONC",
                      "0.10",
                      const Color(0xFFD0D5DD),
                      const Color(0xFF4E0CA2), // Active color for Ooni Coin
                      selectedCoin ==
                          "Ooni Coin", // Check if this coin is selected
                      () {
                        _onCoinSelected("Ooni Coin");
                      },
                    ),
                    _rewardButtonCoin(
                      context,
                      "assets/lordMed.png",
                      "Lord Coin",
                      "LDC",
                      "0.10",
                      const Color(0xFFD0D5DD),
                      const Color(0xFF4E0CA2), // Active color for Ooni Coin
                      selectedCoin ==
                          "Lord Coin", // Check if this coin is selected
                      () {
                        _onCoinSelected("Lord Coin");
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                    "Note that the selected currency would be your default currency and can not be changed on any condition and will also be used to process your withdrawals.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RewardScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4e0ca2),
                        minimumSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Continue",
                          style: TextStyle(
                            fontSize: 14.701570510864258,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ))),
                )
              ],
            ),
          ),
        ));
  }

  Widget _rewardButtonCoin(
    context,
    String image,
    String name,
    String acro,
    String rate,
    Color color,
    Color activeColor,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
              color: isSelected ? activeColor : color,
              borderRadius: BorderRadius.circular(18)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: 60,
                height: 60,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              Text(
                acro,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              Text(rate,
                  style: TextStyle(
                    fontSize: 12.077787399291992,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : Colors.black,
                  )),
              Text("Today’s rate",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: isSelected ? Colors.white : Colors.black,
                  ))
            ],
          )),
    );
  }
}
