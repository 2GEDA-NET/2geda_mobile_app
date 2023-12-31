import 'package:_2geda/pages/authentication/verify.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _isUsingPhoneNumber = false; // Track if using phone number

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
              const Text(
                "Reset your password",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: _isUsingPhoneNumber
                      ? 'Phone Number'
                      : 'Email', // Label text for the input field
                  hintText: _isUsingPhoneNumber
                      ? 'Enter your phone number'
                      : 'Enter your email', // Hint text for the input field
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Set the border radius to 8
                  ),
                ),
                keyboardType: _isUsingPhoneNumber
                    ? TextInputType.phone
                    : TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return _isUsingPhoneNumber
                        ? 'Please enter your phone number'
                        : 'Please enter your email';
                  }
                  // You can add more validation logic here as needed
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "We’ll send a verification code to your Phone number or email address to verify that you are 2geda with us.",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isUsingPhoneNumber = !_isUsingPhoneNumber;
                  });
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xff4e0ca2),
                ),
                child: Text(
                  _isUsingPhoneNumber
                      ? "Use Email instead"
                      : "Use Phone number instead",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.5, // Adjust the fraction as needed
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const VerifyOTPScreen(), // Replace with the actual screen
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2), // Change background color
                  minimumSize: const Size(500, 60), // Increase width and height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Add border radius
                  ),
                ),
                child: const Text(
                  "Send Code",
                  style: TextStyle(
                    fontSize: 17,
                        color: Colors.white,
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

void main() {
  runApp(const MaterialApp(
    home: ForgotPasswordScreen(),
  ));
}
