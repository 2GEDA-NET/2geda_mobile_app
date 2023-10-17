import 'package:_2geda/pages/authentication/sign-in.dart';
import 'package:_2geda/pages/authentication/verify.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OpenAccountScreen extends StatefulWidget {
  const OpenAccountScreen({Key? key}) : super(key: key);

  @override
  State<OpenAccountScreen> createState() => _OpenAccountScreenState();
}

class _OpenAccountScreenState extends State<OpenAccountScreen> {
  bool _isObscured = true;
  bool _isUsingPhoneNumber = false; // Track if using phone number

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 80,
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
        // Wrap the content in SingleChildScrollView
        child: Align(
          // Align the content to the right
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(
              top: 25, // Adjust the top margin to 100
              left: 30, // Left margin
              right: 30, // Right margin
              bottom: 30, // Bottom margin
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align everything to the right
              children: [
                Text(
                  _isUsingPhoneNumber
                      ? "Sign up with phone number"
                      : "Sign up with email",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: _isUsingPhoneNumber
                        ? 'Phone Number'
                        : 'Email', // Label text for the input field
                    hintText: _isUsingPhoneNumber
                        ? 'Enter your phone number'
                        : 'Enter your email', // Hint text for the input field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Set the border radius to 8
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
                Text(
                  "We’ll verify the ${_isUsingPhoneNumber ? 'phone number' : 'email'} provided to be sure it belongs to you",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isUsingPhoneNumber = !_isUsingPhoneNumber;
                    });
                  },
                  style: TextButton.styleFrom(
                    primary: const Color(0xff4e0ca2),
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username', // Label text for the input field
                    hintText:
                        'Enter your username', // Hint text for the input field
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
                      return 'Please enter your username';
                    }
                    // You can add more validation logic here as needed
                    return null; // Return null if validation passes
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Set the border radius to 8
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscured =
                              !_isObscured; // Toggle password visibility
                        });
                      },
                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey, // Customize the eye icon color
                      ),
                    ),
                  ),
                  obscureText:
                      _isObscured, // Use the _isObscured state to toggle visibility
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    // Add password validation logic here
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    // You can add more validation logic here as needed
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign In",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff4e0ca2), // Customize the color
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SignInScreen(), // Replace with the actual screen
                              ),
                            );
                            // Add your navigation logic when "Sign In" is tapped
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.2, // Adjust the fraction as needed
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
                    primary: const Color(0xff4e0ca2), // Change background color
                    minimumSize:
                        const Size(500, 60), // Increase width and height
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Add border radius
                    ),
                  ),
                  child: const Text(
                    "Continue",
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
      ),
    );
  }
}
