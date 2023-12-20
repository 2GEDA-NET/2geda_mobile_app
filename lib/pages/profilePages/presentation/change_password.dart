import 'package:_2geda/SideBar/sidebar_layout.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordController = TextEditingController();
  bool _isObscured = true;
  bool _isObscured1 = true;
  bool _isObscured2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Change Password',
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Input current password",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController, // Bind the controller
                decoration: InputDecoration(
                  labelText: 'Current Password',
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
              const Text("New Password",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
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
                        _isObscured1 = !_isObscured1;
                      });
                    },
                    icon: Icon(
                      _isObscured1 ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
                obscureText: _isObscured1,
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
                controller: passwordController, // Bind the controller
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscured2 = !_isObscured2;
                      });
                    },
                    icon: Icon(
                      _isObscured2 ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
                obscureText: _isObscured2,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  "Password must contain Capital and small letters, number or symbols.",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SideBarLayout(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4e0ca2),
                    minimumSize: const Size(300, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
