// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:_2geda/APIServices/authentication_api_services.dart';
import 'package:_2geda/SideBar/sidebar_layout.dart';
import 'package:_2geda/auth_provider.dart';
import 'package:_2geda/pages/authentication/forget_password.dart';
import 'package:_2geda/pages/authentication/sign_up.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthenticationApiService signInApiService = AuthenticationApiService();
  final TokenManager tokenManager = TokenManager();

  bool _isObscured = true;
  bool _isChecked = false;
  bool _useEmail = true; // Add this variable to track email/phone toggle
  bool _useUsername = false; // Add this variable to track username toggle

  TextEditingController emailOrPhoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signIn(String loginIdentifier, String password) async {
    String username = emailOrPhoneNumberController.text;
    String password = passwordController.text;
    try {
      final response = await signInApiService.signIn(username, password);

      if (response.statusCode == 200) {
        // Successful sign-in, handle the response as needed
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        final token = responseBody['token'];

        // Use the TokenManager to save the token
        await tokenManager.saveToken(token);

        // Handle the successful registration, for example, by navigating to the next screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SideBarLayout(),
          ),
        );
        // Extract the token or any other data you need from responseBody
      } else {
        // Handle sign-in failure (display an error message)
        final errorMessage = response.body;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign-In Failed'),
              content: Text(
                  'Sign-in failed with the following error:\n$errorMessage'),
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
    } catch (e) {
      // Handle any exceptions or errors during the API call
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign-In Failed'),
              content: Text('Sign-in failed with the following error:\n$e'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 182,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x004f0da3), Color(0xff4f0da3)],
                      ),
                    ),
                    child: Image.asset(
                      'assets/sign-in-img.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/2geda-logo.png',
                          width: 54,
                          height: 54,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Column(
                          children: [
                            Text(
                              "Welcome Back, \nexplore fresh updates.",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  right: 30,
                  left: 30,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _useEmail
                            ? "Sign-in with Email"
                            : (_useUsername
                                ? "Sign-in with Username"
                                : "Sign-in with Phone Number"), // Change label text
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller:
                            emailOrPhoneNumberController, // Bind the controller
                        decoration: InputDecoration(
                          labelText: _useEmail
                              ? 'Email'
                              : (_useUsername
                                  ? 'Username'
                                  : 'Phone Number'), // Change field label
                          hintText: _useEmail
                              ? 'Enter your email'
                              : (_useUsername
                                  ? 'Enter your username'
                                  : 'Enter your phone number'), // Change hint text
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        keyboardType: _useEmail
                            ? TextInputType.emailAddress
                            : (_useUsername
                                ? TextInputType.text
                                : TextInputType.phone), // Change keyboard type
                        validator: (value) {
                          if (_useEmail) {
                            // ... (your existing email validation)
                          } else if (_useUsername) {
                            // Add validation logic for username if needed
                          } else {
                            // ... (your existing phone number validation)
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController, // Bind the controller
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
                              _isObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        obscureText: _isObscured,
                        keyboardType: TextInputType.text,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Forgot password?",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors
                                    .black, // Set the text color to your desired color
                              ),
                            ),
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
                              const Text("Keep me signed in"),
                            ],
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _useEmail =
                                !_useEmail; // Toggle between email and phone
                            _useUsername = false; // Reset _useUsername to false
                          });
                        },
                        child: Text(
                          _useEmail ? "Use Phone Number" : "Use Email",
                          style: const TextStyle(
                            color: Color(0xff4e0ca2),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _useUsername =
                                !_useUsername; // Toggle between username and phone number
                          });
                        },
                        child: Text(
                          _useUsername ? "Use Phone Number" : "Use Username",
                          style: const TextStyle(
                            color: Color(0xff4e0ca2),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OpenAccountScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "New here? Sign Up",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          signIn(emailOrPhoneNumberController.text,
                              passwordController.text);
                          context.read<AuthProvider>().login();

                          if (_isChecked) {
                            // If the user has checked the checkbox, persist the authentication status.
                            try {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('isSignedIn', true);
                            } catch (e) {
                              // Handle any exceptions that might occur while saving to shared preferences.
                              print('Error saving authentication status: $e');
                            }
                          }

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const SideBarLayout(),
                          //   ),
                          // );
                        },
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
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
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
