import 'package:_2geda/SideBar/sidebar_layout.dart';
import 'package:flutter/material.dart';

class PaymentSuceess extends StatelessWidget {
  const PaymentSuceess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/success.png'),
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                  textAlign: TextAlign.center,
                  "Your ticket purchase was successful You will receive a mail containing your ticket soon.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SideBarLayout(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(500, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Back to home",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
