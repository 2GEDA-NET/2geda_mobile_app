// account_screen.dart

import 'package:_2geda/pages/businessDirectoryPages/claim_business_form.dart';
import 'package:flutter/material.dart';

class ClaimBusinessPage extends StatelessWidget {
  const ClaimBusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Claim Business',
          style: TextStyle(color: Color(0xff4e0ca2)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Dear Business Owner,',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 5,
              ),
              const Text(
                  "Thank you for your interest in claiming your business on 2geda. To ensure the accuracy and security of our directory, we require that you verify your ownership of the business before proceeding.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                height: 15,
              ),
              const ExpansionTile(
                title: Text(
                  "Why Ownership Verification is Important",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        "Verifying ownership helps us maintain the integrity of our directory and ensures that only authorized individuals have control over their business listings. This process helps prevent unauthorized claims and keeps the information up-to-date and accurate for our users.",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("To claim your business, follow the steps below",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )),
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("STEP 1",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          )),
                      Text("Provide business information",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Container(
                  width: 5,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10), // Adjust the radius as needed
                      bottom:
                          Radius.circular(10), // Adjust the radius as needed
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("STEP 2",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          )),
                      Text("Upload Ownership Documents",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Container(
                  width: 5,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10), // Adjust the radius as needed
                      bottom:
                          Radius.circular(10), // Adjust the radius as needed
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("STEP 3",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          )),
                      Text("Verify your identity",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                    ]),
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'Important Note: ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none, // Remove underline
                        color: Colors.black, // Set the desired text color
                      ),
                    ),
                    TextSpan(
                      text:
                          'Falsely claiming a business that you do not own is a violation of our terms of service and may result in the removal of your listing. Please only proceed with claiming your business if you are the rightful owner or authorized representative.',
                      style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.none, // Remove underline
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ClaimBusinessForm(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Proceed to claim",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
