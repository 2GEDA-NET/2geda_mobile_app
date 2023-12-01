// account_screen.dart

import 'package:_2geda/SideBar/sidebar_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class PromotionPreviewPage extends StatelessWidget {
  const PromotionPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Promotion Preview',
          style: TextStyle(color: Color(0xff4e0ca2)),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.thunderstorm),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0x33d9d9d9),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 5), // Add some spacing
                    const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center the children
                      children: [
                        Icon(Icons.thunderstorm),
                        SizedBox(width: 5), // Add spacing between icon and text
                        Text(
                          "Toyota Venza 2021 Mobile V6",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5), // Add some spacing
                    const Text(
                      "#20,000,000",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4e0ca2),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xff4e0ca2)),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Promotion plan : 1 day",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        )),
                    Text("Amount : #10,000",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text("Start date",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  )),
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
                  labelText: 'Promotion start date',
                  labelStyle: TextStyle(fontSize: 12),
                ),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.always,
                lastDate: DateTime.now().subtract(
                    const Duration(days: 1)), // Set lastDate to yesterday
                initialDate: DateTime.now().subtract(const Duration(
                    days: 1)), // Set initialDate to yesterday or earlier
                onDateSelected: (DateTime value) {
                  print(value);
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SideBarLayout(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffff8a15),
                  minimumSize: const Size(500, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Pay Now",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
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
