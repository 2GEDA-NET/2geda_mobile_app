import 'package:flutter/material.dart';

class RewardPayment extends StatefulWidget {
  const RewardPayment({super.key});

  @override
  State<RewardPayment> createState() => _RewardPaymentState();
}

class _RewardPaymentState extends State<RewardPayment> {
  String selectedValue = 'NGN'; // Set to one of the items in the list
  List<String> dropdownItems = ['NGN', 'USD', 'GBP', 'EUR'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Payment',
            ),
            centerTitle: true,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/2geda-purple.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFEAE3F9)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("You are withdrawing",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          "assets/ooniMed.png",
                          width: 20,
                          height: 20,
                        ),
                        const Text("500",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("You will get",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )),
                          Text("50,000",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  const Text("Withdrawal information",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4E0CA2),
                      )),
                      DropdownButtonFormField<String>(
                        value: selectedValue,
                        items: dropdownItems.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: SizedBox(
                              height:
                                  20, // Adjust the height of the DropdownMenuItem
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
                        icon: const Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 30, // Adjust the icon size
                        ),
                      ),
                ],
              ),
                
              
            ],
          ),
        ));
  }
}
