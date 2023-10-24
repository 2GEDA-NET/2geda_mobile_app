import 'package:_2geda/pages/ticketPages/buyTicket/payment_success.dart';
import 'package:flutter/material.dart';

class MakePaymentPage extends StatelessWidget {
  const MakePaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Make Payment',
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all(width: 1)),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(color: Colors.amber),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Meta app unveil",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  )),
                              const Spacer(),
                              Container(
                                decoration:
                                    BoxDecoration(border: Border.all(width: 1)),
                                child: const Text("Ticket x3",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(Icons.location_on),
                              Text("Eko Hotel and suites conference hall ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(Icons.calendar_month),
                              Text("Thur, 17 Aug 2023 , 9:30 PM ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ],
                          ),
                          const Center(
                            child: Text('Account Screen Content'),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Amount",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                          Text("13,000",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  labelText: 'Card Number', // Label text for the input field
                  hintStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText:
                      'Enter 16 digit card number', // Hint text for the input field
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
                    return 'Please enter 16 digit card number';
                  }
                  // You can add more validation logic here as needed
                  return null; // Return null if validation passes
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  labelText: 'Name on Card', // Label text for the input field
                  hintStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText:
                      'Enter name on card', // Hint text for the input field
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
                    return 'Please enter name on card';
                  }
                  // You can add more validation logic here as needed
                  return null; // Return null if validation passes
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        labelText:
                            'Card pin', // Label text for the input field
                        hintStyle: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText:
                            'Enter 4 digit pin', // Hint text for the input field
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
                          return 'Please enter 4 digit pin';
                        }
                        // You can add more validation logic here as needed
                        return null; // Return null if validation passes
                      },
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        labelText:
                            'CVV', // Label text for the input field
                        hintStyle: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText:
                            'Enter cvv', // Hint text for the input field
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
                          return 'Please enter cvv';
                        }
                        // You can add more validation logic here as needed
                        return null; // Return null if validation passes
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentSuceess(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(500, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
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
              
              Image.asset('assets/banner2.png')
            ],
          ),
        ),
      ),
    );
  }
}
