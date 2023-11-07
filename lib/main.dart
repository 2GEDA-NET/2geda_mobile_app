// ignore_for_file: unused_field, library_private_types_in_public_api

import 'dart:async';
import 'package:_2geda/pages/onboardingScreens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio_background/just_audio_background.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final customPrimaryColor = const MaterialColor(
    0xFF4E0CA2, // Replace with your desired color value
    <int, Color>{
      50: Color(0xFFEAE3F9),
      100: Color(0xFFC5A6E6),
      200: Color(0xFF9E69D2),
      300: Color(0xFF782CC0),
      400: Color(0xFF6202A9),
      500: Color(0xFF4E0CA2),
      600: Color(0xFF460991),
      700: Color(0xFF3E0681),
      800: Color(0xFF350470),
      900: Color(0xFF280350),
    },
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set the desired status bar color
      statusBarIconBrightness: Brightness
          .light, // Set the status bar icons and text to be light or dark
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: customPrimaryColor,
        fontFamily: 'Ubuntu',
      ),
      home: const SplashScreen(),
      // Other MaterialApp configurations
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double _progressValue = 0.0;
  late AnimationController _controller;
  late Animation<double> _animation;
  int _loadingDotCount = 1;
  String _loadingText = 'Loading';

  @override
  void initState() {
    super.initState();
    // Simulate progress with a Timer
    Timer.periodic(
      const Duration(milliseconds: 500), // Adjust the duration as needed
      (Timer timer) {
        if (_progressValue >= 1.0) {
          timer.cancel();
          // Check if the widget is still mounted before navigating
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => const OnboardingScreen(),
              ),
            );
          }
        } else {
          setState(() {
            _progressValue += 0.1; // Adjust the progress increment as needed
          });
        }
      },
    );

    // Animation setup for loading text
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat(reverse: true);

    // Timer to cycle loading text
    Timer.periodic(
      const Duration(seconds: 1), // Adjust the duration as needed
      (Timer timer) {
        if (mounted) {
          setState(() {
            _loadingDotCount = (_loadingDotCount + 1) % 4;
            _loadingText = 'Loading${'.' * _loadingDotCount}';
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF4F0DA3), // Set your custom background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/2geda-logo.png', // Replace with your image path
              width: 94.5,
              height: 84,
            ),
            const SizedBox(
                height: 16), // Add some spacing between image and text
            const Text(
              'The platform we built together',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white, // Set your text color
              ),
            ),
            const SizedBox(
                height: 80), // Add some spacing between text and progress bar
            Container(
              width: 200, // Set your desired width for the progress bar
              height: 15, // Set your desired height for the progress bar
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Rounded border
                border:
                    Border.all(color: Colors.white, width: 2), // White border
              ),
              child: LinearProgressIndicator(
                value: _progressValue,
                valueColor: const AlwaysStoppedAnimation<Color>(
                    Colors.white), // Transparent progress bar color
                backgroundColor:
                    Colors.transparent, // Transparent background color
              ),
            ),
            const SizedBox(
                height: 20), // Add some spacing between text and progress bar
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(seconds: 1),
              builder: (BuildContext context, double value, Widget? child) {
                return Opacity(
                  opacity: value,
                  child: Text(
                    _loadingText,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white, // Set your text color
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
