// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';
import 'package:_2geda/APIServices/authentication_api_services.dart';
import 'package:_2geda/SideBar/sidebar_layout.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key});

  @override
  _VerifyOTPScreenState createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final TextEditingController _otpController = TextEditingController();
  int countdown = 150; // 2 and half minutes in seconds

  Future<void> _verifyOTP(String otp) async {
    // Get the user's authentication token from shared preferences
    final token = await TokenManager().getToken();

    if (token == null) {
      // Handle the case where the token is not available.
      // You might want to navigate the user to the login screen.
      return;
    }

    // Use the AuthenticationApiService to verify OTP
    final apiService = AuthenticationApiService();

    try {
      await apiService.verifyOTP(otp, token);

      // If the verification is successful, navigate to the home screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              const SideBarLayout(), // Replace with your home screen widget
        ),
      );
    } catch (e) {
      // Handle errors or failed OTP verification
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect OTP. Please try again.'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel(); // Stop the countdown when it reaches 0
        }
      });
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor:
            const Color(0x33d9d9d9), // Set the background color to grey
        leading: GestureDetector(
          onTap: () {
            // Handle back button press here (e.g., pop the current screen)
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back, // Use the back icon of your choice
            color: Colors.black, // Customize the color
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // Adjust the spacing
            child: Image.asset(
              'assets/2geda-purple.png', // Replace with your logo asset
              width: 40, // Adjust the width as needed
              height: 40, // Adjust the height as needed
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Please verify your email",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 10),
              const Text("We sent a 5 digits code to your email",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(height: 20),
              PinCodeTextField(
                appContext: context,
                length: 5, // Define the length of the OTP
                controller: _otpController,
                onChanged: (otp) {
                  // Handle OTP changes
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 55,
                  fieldWidth: 53,
                  activeFillColor:
                      const Color(0xff4f0da3), // Set the filled color to purple
                  inactiveFillColor: Colors
                      .transparent, // Make the inactive (unfilled) boxes transparent
                  activeColor: const Color(
                      0xff4f0da3), // Set the border color to purple when active
                  inactiveColor: const Color(
                      0xff4f0da3), // Set the border color to purple when inactive
                  selectedColor: const Color(
                      0xff4f0da3), // Set the border color when selected
                  selectedFillColor: const Color(
                      0xff4f0da3), // Set the filled color when selected
                ),
                keyboardType: TextInputType.number,
                autoFocus: true,
                animationType: AnimationType.fade,
                animationDuration: const Duration(milliseconds: 300),
                textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                enableActiveFill: true,
                onCompleted: (otp) {
                  // Called when all the OTP digits are entered
                  // You can perform OTP verification here
                  _verifyOTP(otp);
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formatDuration(Duration(seconds: countdown)),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: countdown == 0
                          ? () {
                              // Add logic to resend the OTP here
                              // You can implement the OTP resending logic in this callback
                              // For now, let's display a message to simulate the resend action.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Resending OTP...'), // Replace with your actual logic
                                ),
                              );
                            }
                          : null, // Disable the button if countdown is not complete
                      child: const Text(
                        "Didn’t get code? Resend code",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          decoration:
                              TextDecoration.underline, // Underline the text
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              ElevatedButton(
                onPressed: _otpController.text.length ==
                        5 // Check if OTP is filled
                    ? () {
                        String otp = _otpController.text;
                        _verifyOTP(otp);
                      }
                    : null, // Set onPressed to null to disable the button if OTP is not filled
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.disabled)) {
                      // Set the color for the disabled state here
                      return const Color(
                          0x7f4e0ca2); // Replace with your desired color
                    }
                    return const Color(
                        0xff4e0ca2); // Color for the enabled state
                  }),
                  minimumSize: MaterialStateProperty.all(const Size(500, 60)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                child: const Text(
                  "Verify",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
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

void main() {
  runApp(const MaterialApp(
    home: VerifyOTPScreen(),
  ));
}
