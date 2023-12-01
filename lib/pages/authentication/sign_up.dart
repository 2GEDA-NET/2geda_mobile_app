// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:_2geda/APIServices/authentication_api_services.dart';
import 'package:_2geda/pages/authentication/sign-in.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/authentication/verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class OpenAccountScreen extends StatefulWidget {
  const OpenAccountScreen({Key? key}) : super(key: key);

  @override
  State<OpenAccountScreen> createState() => _OpenAccountScreenState();
}

class _OpenAccountScreenState extends State<OpenAccountScreen> {
  final AuthenticationApiService registrationApiService =
      AuthenticationApiService();

  final TokenManager tokenManager = TokenManager();

  bool _isObscured = true;
  bool _isUsingPhoneNumber = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailOrPhoneNumberController =
      TextEditingController();

  Future<void> signUp() async {
    final username = usernameController.text;
    final password = passwordController.text;
    final emailOrPhoneNumber = emailOrPhoneNumberController.text;

    final response = await registrationApiService.signUp(
      username,
      password,
      emailOrPhoneNumber,
      _isUsingPhoneNumber,
    );

    if (response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      final token = responseBody['token'];

      // Use the TokenManager to save the token
      await tokenManager.saveToken(token);

      // Handle the successful registration, for example, by navigating to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VerifyOTPScreen(),
        ),
      );
    } else {
      try {
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        final List<dynamic> errorMessages =
            errorResponse.values.map((value) => value.toString()).toList();

        final errorMessage = errorMessages.join('\n');

        // Show an error dialog with the extracted error messages
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Registration Failed'),
              content: Text(
                  'Registration failed with the following error:\n$errorMessage'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } catch (e) {
        // If the response is not JSON, treat it as a plain text error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Registration Failed'),
              content: Text(
                  'Registration failed with the following error:\n${response.body}'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: const Color(0x33d9d9d9),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/2geda-purple.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(
              top: 25,
              left: 30,
              right: 30,
              bottom: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    labelText: _isUsingPhoneNumber ? 'Phone Number' : 'Email',
                    hintText: _isUsingPhoneNumber
                        ? 'Enter your phone number'
                        : 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  keyboardType: _isUsingPhoneNumber
                      ? TextInputType.phone
                      : TextInputType.emailAddress,
                  controller: emailOrPhoneNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return _isUsingPhoneNumber
                          ? 'Please enter your phone number'
                          : 'Please enter your email';
                    }
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  controller: usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
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
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  obscureText: _isObscured,
                  keyboardType: TextInputType.text,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
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
                          color: Color(0xff4e0ca2),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4e0ca2),
                    minimumSize: const Size(500, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Continue",
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
      ),
    );
  }
}
