import 'package:_2geda/pages/ticketPages/buyTicket/presentation/comps/make_payment.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecieverDetails extends StatefulWidget {
  const RecieverDetails({super.key});

  @override
  State<RecieverDetails> createState() => _RecieverDetailsState();
}

class _RecieverDetailsState extends State<RecieverDetails> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Reciever Details',
          style: TextStyle(color: Colors.black),
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
            children: [
              const Text("Enter receiver details to continue ticket purchase",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  labelText: 'First Name', // Label text for the input field
                  hintStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText:
                      'Enter your first name', // Hint text for the input field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the border radius to 8
                  ), // Add a border to the input field
                ),
                keyboardType: TextInputType
                    .text, // Set the keyboard type to email address
                validator: (value) {
                  // Add email validation logic here (e.g., check if it's a valid email)
                  if (value == null || value.isEmpty) {
                    return 'Please enter your First Name';
                  }
                  // You can add more validation logic here as needed
                  return null; // Return null if validation passes
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  labelText: 'Last Name', // Label text for the input field
                  hintStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText:
                      'Enter your last name', // Hint text for the input field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the border radius to 8
                  ), // Add a border to the input field
                ),
                keyboardType: TextInputType
                    .text, // Set the keyboard type to email address
                validator: (value) {
                  // Add email validation logic here (e.g., check if it's a valid email)
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Last Name';
                  }
                  // You can add more validation logic here as needed
                  return null; // Return null if validation passes
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  labelText: 'Email Address', // Label text for the input field
                  hintStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText:
                      'Enter your email address', // Hint text for the input field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the border radius to 8
                  ), // Add a border to the input field
                ),
                keyboardType: TextInputType
                    .text, // Set the keyboard type to email address
                validator: (value) {
                  // Add email validation logic here (e.g., check if it's a valid email)
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  // You can add more validation logic here as needed
                  return null; // Return null if validation passes
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  labelText: 'Address', // Label text for the input field
                  hintStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText:
                      'Enter your address', // Hint text for the input field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the border radius to 8
                  ), // Add a border to the input field
                ),
                keyboardType: TextInputType
                    .text, // Set the keyboard type to email address
                validator: (value) {
                  // Add email validation logic here (e.g., check if it's a valid email)
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  // You can add more validation logic here as needed
                  return null; // Return null if validation passes
                },
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (newValue) {
                      setState(() {
                        _isChecked = newValue!;
                      });
                    },
                  ),
                  Text.rich(
                    TextSpan(
                      text: "I have read and agreed to ",
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "terms & conditions",
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w900,
                            color: Color(0xff4e0ca2),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              const url =
                                  'https://example.com/terms_and_conditions'; // Replace with your actual URL
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                        ),
                        const TextSpan(text: " and the \n"),
                        TextSpan(
                          text: "privacy policy",
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w900,
                            color: Color(0xff4e0ca2),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              const url =
                                  'https://example.com/privacy_policy'; // Replace with your actual URL
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // builder: (context) => const MakePaymentPage(),
                      builder: (context) => const MakePaymentPage(),
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
                  "Check Out",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
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
