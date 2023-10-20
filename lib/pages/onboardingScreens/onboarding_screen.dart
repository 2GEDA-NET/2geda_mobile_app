import 'package:_2geda/pages/authentication/sign-in.dart';
import 'package:_2geda/pages/authentication/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async'; // Import for Timer

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return const MaterialApp(
      home: OnboardingScreen(),
      // Other MaterialApp configurations
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  List<OnboardingPage> onboardingPages = [
    const OnboardingPage(
      title: 'Unlock Business \nand Personal \nPotentials',
      subtitle:
          'Meet prospective clients and \nvendors for your next product or \nservice needs',
    ),
    const OnboardingPage(
      title: 'Connect with \nDiverse \nBusinesses',
      subtitle:
          'Boost local businesses on our app. \nConnect, engage, and grow \ntogether socially',
    ),
    const OnboardingPage(
      title: 'Explore Our \nInclusive Business \nDirectory',
      subtitle:
          'Discover a diverse array of \nbusinesses in our inclusive directory \ntoday.',
    ),
  ];

  int _currentPage = 0;
  late Timer _timer; // Timer for automatic page change

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      // This function will be called every 5 seconds
      if (_currentPage < onboardingPages.length - 1) {
        // If not on the last page, move to the next page
        _currentPage++;
      } else {
        // If on the last page, reset to the first page
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when disposing of the screen
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set the desired status bar color
      statusBarIconBrightness: Brightness.dark, // Set the status bar icons and text to be light or dark
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(
          top: 50, // Adjust the top margin to 100
          left: 25, // Left margin
          right: 25, // Right margin
          bottom: 30, // Bottom margin
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align items to the left
          children: [
            Image.asset(
              'assets/2geda-purple.png',
              width: 70,
              height: 70,
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 200, // Set the desired height for the PageView
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,
                itemBuilder: (context, index) {
                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: _currentPage == index ? 1.0 : 0.0,
                    child: onboardingPages[index],
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                pageSnapping: true, // Enable page snapping
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.2, // Adjust the fraction as needed
            ),
            SizedBox(
              height: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingPages.length,
                  (index) {
                    return Container(
                      width: 20.0,
                      height:
                          5.0, // Make the height equal to the width to create a circle
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: _currentPage == index
                            ? BoxShape
                                .rectangle // Use rectangle for active page
                            : BoxShape.circle, // Use circle for inactive pages
                        color: _currentPage == index
                            ? const Color(0xff4e0ca2) // Active indicator color
                            : Colors.grey.withOpacity(
                                0.5), // Inactive indicator color with opacity
                        borderRadius: _currentPage == index
                            ? BorderRadius.circular(
                                5.0) // Adjust the border radius for the active page
                            : null, // No border radius for inactive pages
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const OpenAccountScreen(), // Replace with the actual screen
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4e0ca2), // Change background color
                      minimumSize:
                          const Size(500, 60), // Increase width and height
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Add border radius
                      ),
                    ),
                    child: const Text(
                      "Open an account",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SignInScreen(), // Replace with the actual screen
                        ),
                      );
                      // Handle "Login" button press
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          width: 0.5,
                          color: Color(0xff4e0ca2)), // Border width and color
                      minimumSize: const Size(500, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Add border radius
                      ),
                    ),
                    child: const Text("Sign in",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff4e0ca2),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text.rich(
                    TextSpan(
                      text:
                          "By Continuing to use this platform, you agree to the ",
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Terms & Conditions",
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
                        const TextSpan(text: " and the "),
                        TextSpan(
                          text: "Privacy Policy",
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
                        const TextSpan(text: " of 2geda."),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 25),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
