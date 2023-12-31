import 'package:_2geda/pages/widgets/polls/polls_details.dart';
import 'package:flutter/material.dart';

class PollsPaymentSuccess extends StatelessWidget {
  const PollsPaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/success.png"),
            const SizedBox(
              height: 20,
            ),
            const Text("Payment successful!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  minimumSize: const Size(
                      300, 50), // Adjust the width and height as needed
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Adjust the border radius
                  ),
                ),
                child: const Text("Continue to poll",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
