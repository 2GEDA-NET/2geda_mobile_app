import 'package:_2geda/SideBar/sidebar_layout.dart';
import 'package:_2geda/pages/widgets/polls/polls_success.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class VotingProgressBar extends StatefulWidget {
  final double progress;
  final String text;

  VotingProgressBar({super.key, required this.progress, required this.text});

  static const token = '908AD23M';

  @override
  State<VotingProgressBar> createState() => _VotingProgressBarState();
}

class _VotingProgressBarState extends State<VotingProgressBar> {
  TextEditingController _votesController = TextEditingController();
  TextEditingController _voteNumbercontroller = TextEditingController();
  String selectedValue = 'USD';
  double exchangeRateUSDToNGN = 410.0; // Replace with actual exchange rates
  double exchangeRateUSDtoEuro = 0.85; // Replace with actual exchange rates

  void copyToClipboard(BuildContext context, String textToCopy) {
    FlutterClipboard.copy(textToCopy).then((_) {
      final snackBar = SnackBar(
        backgroundColor: const Color(0xff4e0ca2),
        content: Text('Copied to clipboard: $textToCopy'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((error) {
      final snackBar = SnackBar(
        content: Text('Failed to copy to clipboard: $error'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showVoteDetailsDialog(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            LinearProgressIndicator(
              minHeight: 25,
              value: widget.progress,
              backgroundColor: Colors.black,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF4E0CA2)),
              borderRadius: BorderRadius.circular(10),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.text,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          )),
                      Text(
                        '${(widget.progress * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVoteDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Important: Copy Your Unique Token",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.42,
            child: Column(
              children: [
                const Text(
                    "Thank you for participating in our poll! To ensure the integrity of the voting process and to verify your identity, we've generated a unique token for you. Please take a moment to copy this token as you'll need it to submit your vote.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(79, 13, 163, 0.1),
                  ),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(VotingProgressBar.token),
                        IconButton(
                          onPressed: () {
                            copyToClipboard(context, VotingProgressBar.token);
                          },
                          icon: const Icon(
                            Icons.copy,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Please note: This token can be used only once",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      // Show the next dialog
                      _showAccessPollDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4e0ca2),
                      minimumSize: const Size(
                          250, 40), // Adjust the width and height as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Adjust the border radius
                      ),
                    ),
                    child: const Text("Continue",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white))),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                        250, 40), // Adjust the width and height as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the border radius
                    ),
                  ),
                  child: const Text(
                    "Go back",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAccessPollDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Access Poll",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Column(
              children: [
                const Text(
                    "To continue voting please input the Unique ID provided for you.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      // Show the next dialog
                      _showRequestAccessPollDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4e0ca2),
                      minimumSize: const Size(
                          250, 40), // Adjust the width and height as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Adjust the border radius
                      ),
                    ),
                    child: const Text("Continue",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white))),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                        250, 40), // Adjust the width and height as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the border radius
                    ),
                  ),
                  child: const Text(
                    "Go back",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRequestAccessPollDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Request Poll Access",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              children: [
                const Text(
                    "This is a private poll, to access this poll, you can request access from the poll owner",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      // Show the next dialog
                      _showPaidPollDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4e0ca2),
                      minimumSize: const Size(
                          250, 40), // Adjust the width and height as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Adjust the border radius
                      ),
                    ),
                    child: const Text("Request access",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white))),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                        250, 40), // Adjust the width and height as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the border radius
                    ),
                  ),
                  child: const Text(
                    "Go back",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPaidPollDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Paid Poll",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                const Text(
                    "This is a paid poll, your contribution ensures meaningful insights. Participate now to support quality content and exclusive results",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 120,
                        child: TextFormField(
                          controller: _votesController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Number of votes',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              calculateTotalPrice(); // Update conversion when votes change
                            });
                          },
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: DropdownButtonFormField<String>(
                                value: selectedValue,
                                items:
                                    ['USD', 'NGN', 'Euro'].map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: SizedBox(
                                      height: 20,
                                      child: Center(
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue!;
                                  });
                                  // Call calculateTotalPrice() here to update the conversion
                                  calculateTotalPrice();
                                },
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 30,
                                ),
                                decoration: const InputDecoration.collapsed(
                                  hintText: '',
                                ),
                              ),
                            ),
                            Text(
                              ' ${calculateTotalPrice()}',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      // Show the next dialog
                      _showPaymentDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4e0ca2),
                      minimumSize: const Size(
                          250, 40), // Adjust the width and height as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Adjust the border radius
                      ),
                    ),
                    child: const Text("Proceed to pay",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white))),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                        250, 40), // Adjust the width and height as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the border radius
                    ),
                  ),
                  child: const Text(
                    "Go back",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  double calculateTotalPrice() {
    // Calculate total price based on entered votes and selected currency
    double votes = double.tryParse(_votesController.text) ?? 0.0;
    double price = votes;

    if (selectedValue == 'NGN') {
      price *= exchangeRateUSDToNGN;
    } else if (selectedValue == 'Euro') {
      price *= exchangeRateUSDtoEuro;
    }

    return price;
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                const Text("You are paying",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF4E0CA2),
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text("NGN 4,700.00",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4E0CA2),
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text("Being payment for",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF4E0CA2),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.grey[400]),
                  child: const Text("40 votes",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF4E0CA2),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      // Show the next dialog
                      // _showPaidPollDialog(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PollsPaymentSuccess(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4e0ca2),
                      minimumSize: const Size(
                          250, 40), // Adjust the width and height as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Adjust the border radius
                      ),
                    ),
                    child: const Text("Pay now",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white))),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                        250, 40), // Adjust the width and height as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the border radius
                    ),
                  ),
                  child: const Text(
                    "Go back",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _makeVoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                const Text(
                    "How many votes do you want to cast for this selection?",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _voteNumbercontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter amount',
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          // Handle the "All" button press
                          print('All button pressed');
                        },
                        child: Text('All'),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      // Show the next dialog
                      // _showPaidPollDialog(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SideBarLayout(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4e0ca2),
                      minimumSize: const Size(
                          250, 40), // Adjust the width and height as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Adjust the border radius
                      ),
                    ),
                    child: const Text("Vote",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white))),
              ],
            ),
          ),
        );
      },
    );
  }
}
