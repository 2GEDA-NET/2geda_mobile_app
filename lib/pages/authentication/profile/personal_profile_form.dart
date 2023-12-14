// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:math';

import 'package:_2geda/APIServices/authentication_api_services.dart';
import 'package:_2geda/pages/authentication/profile/profile_image_upload.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';

class ProfileFormPage extends StatefulWidget {
  const ProfileFormPage({super.key});

  @override
  _ProfileFormPageState createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage>
    with SingleTickerProviderStateMixin {
  String selectedValue = ''; // Initialize with a default value
  List<String> dropdownItems = ['Christianity', 'Muslim', 'Indigenous', 'Others'];
  int? selectedIdentity;
  DateTime? selectedDate;
  final TextEditingController _usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController workController = TextEditingController();
  TextEditingController customGenderController = TextEditingController();

  bool isUsernameValid = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add form key

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

  Future<void> updateUserProfile() async {
    final token = await TokenManager().getToken();

    if (token == null) {
      print("Token is null");
      // Handle the case where the token is null, e.g., show an error message.
      return;
    }

    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String work = workController.text;

    if (selectedDate == null) {
      print("Date of birth is missing");
      // Handle the missing date of birth.
      return;
    }

    if (selectedValue.isEmpty) {
      print("Religion is missing");
      // Handle the missing religion.
      return;
    }

    if (selectedIdentity == null) {
      print("Identity is missing");
      // Handle the missing identity.
      return;
    }

    String dateOfBirthFormatted =
        DateFormat('yyyy-MM-dd').format(selectedDate!);
    DateTime dateOfBirth = DateFormat('yyyy-MM-dd').parse(dateOfBirthFormatted);
    print(dateOfBirth);
    int identity = selectedIdentity!;

    String customGender = customGenderController.text;

    print("First Name: ${firstNameController.text}");
    print(firstName);
    print("Last Name: ${lastNameController.text}");
    print(lastName);
    print("Work: ${workController.text}");
    print(work);
    print("Date of Birth: $selectedDate");
    print("Religion: $selectedValue");
    print("Identity: $selectedIdentity");
    print("Custom Gender: ${customGenderController.text}");

    final response = await AuthenticationApiService().updateProfile(
      token,
      firstName,
      lastName,
      work,
      dateOfBirth,
      selectedValue,
      identity,
      customGender,
      {
        'first_name': firstName,
        'last_name': lastName,
      },
    );

    if (response.statusCode == 200) {
      // Profile update was successful.
      print(response.body);
      // Navigate to a success screen or perform any other actions.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ImageUploadPage()),
      );
    } else {
      // Profile update failed. Handle the error and display a message.
      print('Profile update failed: ${response.body}');
      // You might want to show an error message to the user here.
    }
  }

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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // You can use a Column to wrap your content
              children: [
                const Text(
                  "Profile details",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500, // Corrected the typo
                  ),
                ),

                // Add more widgets if needed for your profile details

                const SizedBox(height: 20),
                TextFormField(
                  controller: firstNameController,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'First Name',
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
                  controller: lastNameController,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
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
                  controller: workController,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Work',
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
                DateTimeFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45, fontSize: 12),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 12),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Date of birth',
                    labelStyle: TextStyle(fontSize: 12),
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  firstDate: DateTime(1900), // Set your minimum allowable year
                  lastDate: DateTime.now().subtract(const Duration(days: 1)),
                  initialDate: selectedDate ??
                      DateTime.now().subtract(const Duration(days: 1)),
                  onDateSelected: (DateTime? value) {
                    setState(() {
                      selectedDate = value; // Update the selected date
                    });
                  },
                ),

                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: null,
                  items: dropdownItems.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: SizedBox(
                        height: 20, // Adjust the height of the DropdownMenuItem
                        child: Center(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Religion',
                    labelStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 30, // Adjust the icon size
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  "I identify as",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    _buildRadioContainer(1, 'Female'),
                    const Spacer(),
                    _buildRadioContainer(2, 'Male'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildRadioContainer(3, 'Rather not say'),

                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Custom gender? please specify",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: customGenderController,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Type something here',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Specify the outline border color
                        width: 1.0, // Specify the outline border width
                      ),
                    ),
                  ),
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
                        text: "Username Suggestions: ",
                        style: TextStyle(
                          fontSize: 14,
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
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateUserProfile();
                    }
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

  Widget _buildRadioContainer(int value, String label) {
    final isSelected = selectedIdentity == value;
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        right: 20,
        left: 20,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: isSelected ? activeBackgroundColor : inactiveBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center the children vertically.
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the children horizontally.
            children: [
              Text(
                label,
                style: isSelected ? activeTextStyle : inactiveTextStyle,
              ),
              const SizedBox(
                width: 30,
              ),
              Radio(
                value: value,
                groupValue: selectedIdentity,
                activeColor: Colors.white,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedIdentity = newValue;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ProfileFormPage(),
  ));
}
