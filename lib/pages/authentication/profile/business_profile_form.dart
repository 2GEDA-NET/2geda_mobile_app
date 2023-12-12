// ignore_for_file: unused_local_variable

import 'dart:math';
import 'package:_2geda/pages/authentication/profile/widget/custom_switch.dart';
import 'package:time_range/time_range.dart'; // Import this package for time range selection
import 'package:_2geda/pages/authentication/profile/profile_image_upload.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'package:date_field/date_field.dart';

class BusinessProfileFormPage extends StatefulWidget {
  const BusinessProfileFormPage({super.key});

  @override
  _BusinessProfileFormPageState createState() =>
      _BusinessProfileFormPageState();
}

class _BusinessProfileFormPageState extends State<BusinessProfileFormPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  bool isUsernameValid = false;
  // Define a list to store the availability, opening time, and closing time for each day
  List<BusinessDayInfo> businessWeek = List.generate(
      7,
      (index) => BusinessDayInfo(
          available: false,
          openingTime: TimeOfDay.now(),
          closingTime: TimeOfDay.now()));

  List<TimeOfDay> openingTimes = List.generate(7, (index) => TimeOfDay.now());
  List<TimeOfDay> closingTimes = List.generate(7, (index) => TimeOfDay.now());

  // Define the active and inactive styles for the radio buttons
  final TextStyle activeTextStyle = const TextStyle(
      color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400);
  final TextStyle inactiveTextStyle = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400);
  final Color activeBackgroundColor =
      const Color(0xff4e0ca2); // Change to your desired color
  final Color inactiveBackgroundColor = const Color(0x19000000);
  final List<String> suggestions = [];
  bool _isObscured = true;
  bool isAlwayAvailable = false;
  bool isSwitched = false;
  List<bool> isSwitchedForWeek = List.generate(7, (index) => false);
  bool _isValidUsername(String username) {
    const pattern = r'^@[\w\d_]+$';
    return RegExp(pattern).hasMatch(username);
  }

  void _clearValidation() {
    setState(() {
      // Clear the validation icon.
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, int dayIndex) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: dayIndex < openingTimes.length
          ? openingTimes[dayIndex]
          : closingTimes[dayIndex],
    );
    if (picked != null) {
      setState(() {
        if (dayIndex < openingTimes.length) {
          openingTimes[dayIndex] = picked;
        } else {
          closingTimes[dayIndex - openingTimes.length] = picked;
        }
      });
    }
  }

  void _generateUsernameSuggestions() {
    suggestions.clear();
    final random = Random();
    for (int i = 0; i < 3; i++) {
      final randomWord1 = WordPair.random().asString;
      final randomWord2 = WordPair.random().asString;
      final username = '@$randomWord2$randomWord1';
      suggestions.add(username);
    }
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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // You can use a Column to wrap your content
            children: [
              const Text(
                "Profession or Business details",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),

              // Add more widgets if needed for your profile details

              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Business name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Specify the outline border color
                      width: 1.0, // Specify the outline border width
                    ),                                                     
                  ),
                ),
              ),

              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Specify the outline border color
                      width: 1.0, // Specify the outline border width
                    ),
                  ),
                  suffixIcon: Icon(Icons.work),
                ),
              ),

              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Current City',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Specify the outline border color
                      width: 1.0, // Specify the outline border width
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              DateTimeFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      color: Colors.black45,
                      fontSize: 12), // Change the font size here
                  errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 12), // Change the font size here
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Year Founded',
                  labelStyle: TextStyle(fontSize: 12),
                ),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.always,
                firstDate: DateTime(1900), // Set your minimum allowable year
                lastDate: DateTime.now().subtract(
                    const Duration(days: 1)), // Set lastDate to yesterday
                initialDate: DateTime.now().subtract(const Duration(
                    days: 1)), // Set initialDate to yesterday or earlier
                onDateSelected: (DateTime value) {
                  print(value);
                },
              ),

              const SizedBox(
                height: 30,
              ),

              const Text(
                "Create username",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _usernameController,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  labelText: 'Create Username',
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  suffixIcon: _usernameController.text.isNotEmpty
                      ? _isValidUsername(_usernameController.text)
                          ? const Icon(Icons.check, color: Colors.green)
                          : const Icon(Icons.error, color: Colors.red)
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    // The user is typing, clear the validation icon.
                    // Validation will be checked in real-time.
                    _generateUsernameSuggestions();
                    _clearValidation();
                  });
                },
              ),
              const SizedBox(
                height: 5,
              ),
              if (suggestions.isNotEmpty) const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Try: ",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                    for (int i = 0; i < suggestions.length; i++)
                      TextSpan(
                        text: i < suggestions.length - 1
                            ? '${suggestions[i]}, '
                            : suggestions[i],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _usernameController.text = suggestions[i];
                          },
                      ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Create Password',
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
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Type password again',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 5,
              ),
              const Text(
                "Password must contain Capital and small letters, number or symbols.",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Set Business availability",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Always available",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Checkbox(
                        value: isAlwayAvailable,
                        onChanged: (newValue) {
                          if (newValue != null) {
                            setState(() {
                              isAlwayAvailable = newValue;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Visibility(
                    visible:
                        !isAlwayAvailable, // Hide when "Always available" is checked
                    child: Column(
                      children: [
                        for (int dayIndex = 0; dayIndex < 7; dayIndex++)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomSwitch(
                                    day: getDayName(dayIndex),
                                    isSwitched: isSwitchedForWeek[dayIndex],
                                    onChanged: (value) {
                                      setState(() {
                                        isSwitchedForWeek[dayIndex] = value;
                                      });
                                    },
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(openingTimes[dayIndex]
                                            .format(context)),
                                        IconButton(
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          onPressed: () {
                                            _selectTime(context, dayIndex);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text("To",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(closingTimes[dayIndex]
                                            .format(context)),
                                        IconButton(
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          onPressed: () {
                                            _selectTime(context, dayIndex);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(color: Color(0xfff2e9f9)),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.privacy_tip),
                    Text(
                        "Your data is protected under the Standard International User Act",
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                        ))
                  ],
                ),
              ),

              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ImageUploadPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  minimumSize: const Size(500, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Create Account",
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

  String getDayName(int dayOfWeek) {
    switch (dayOfWeek) {
      case 0:
        return 'Sun';
      case 1:
        return 'Mon';
      case 2:
        return 'Tues';
      case 3:
        return 'Wed';
      case 4:
        return 'Thurs';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      default:
        return 'Unknown';
    }
  }

  Widget TimePicker({
    required String label,
    required TimeOfDay selectedTime,
    required void Function(TimeOfDay) onTimeChanged,
  }) {
    return Row(
      children: [
        Text(label),
        TimeRange(
          fromTitle: const Text('From'),
          toTitle: const Text('To'),
          titlePadding: 20,
          textStyle: const TextStyle(fontSize: 16),
          activeTextStyle: const TextStyle(color: Colors.white),
          borderColor: Colors.blue,
          backgroundColor: Colors.blue,
          activeBackgroundColor: Colors.blue,
          firstTime: const TimeOfDay(hour: 8, minute: 0),
          lastTime: const TimeOfDay(hour: 20, minute: 0),
          timeStep: 15,
          timeBlock: 30,
          onRangeCompleted: (range) {
            onTimeChanged(range!.start);
          },
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: BusinessProfileFormPage(),
  ));
}

class BusinessDayInfo {
  bool available;
  TimeOfDay openingTime;
  TimeOfDay closingTime;

  BusinessDayInfo(
      {required this.available,
      required this.openingTime,
      required this.closingTime});
}
