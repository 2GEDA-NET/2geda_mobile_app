
import 'package:_2geda/pages/profilePages/presentation/reward/referral/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WithDrawScreen extends StatefulWidget {
  const WithDrawScreen({super.key});

  @override
  State<WithDrawScreen> createState() => _WithDrawScreenState();
}

class _WithDrawScreenState extends State<WithDrawScreen> {
  String selectedValue = 'NGN'; // Set to one of the items in the list
  List<String> dropdownItems = ['NGN', 'USD', 'GBP', 'EUR'];

  TextEditingController _controller = TextEditingController(text: '500');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Withdraw',
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontSize: 64,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(
                                  3), // Limit the length to 3 characters
                              TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                                  try {
                                    // Parse the input as an integer
                                    final intValue = int.parse(newValue.text);

                                    // Allow input only if it's less than or equal to 500
                                    return intValue <= 500
                                        ? newValue
                                        : oldValue;
                                  } catch (e) {
                                    // Handle non-integer input
                                    return oldValue;
                                  }
                                },
                              ),
                            ],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Max",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Balance",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                    Image.asset("assets/ooni_coin.png"),
                    const Text("800",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ))
                  ],
                ),
                const Divider(),
                const Text("You will receive",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 60,
                      child: DropdownButtonFormField<String>(
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
                    ),
                    const Text("50,000",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RewardPayment(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4e0ca2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text("NEXT",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
