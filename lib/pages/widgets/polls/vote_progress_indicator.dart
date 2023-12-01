import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class VotingProgressBar extends StatelessWidget {
  final double progress;
  final String text;

  VotingProgressBar({super.key, required this.progress, required this.text});

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

  static const token = '908AD23M';

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
              value: progress,
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
                      Text(text,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          )),
                      Text(
                        '${(progress * 100).toInt()}%',
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
                        const Text(token),
                        IconButton(
                          onPressed: () {
                            copyToClipboard(context, token);
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
                    minimumSize:
                        const Size(250, 40), // Adjust the width and height as needed
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
                    minimumSize:
                        const Size(250, 40), // Adjust the width and height as needed
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
                    minimumSize:
                        const Size(250, 40), // Adjust the width and height as needed
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Number your votes',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      // Show the next dialog
                      // _showNextDialog(context);
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
                    minimumSize:
                        const Size(250, 40), // Adjust the width and height as needed
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
}
