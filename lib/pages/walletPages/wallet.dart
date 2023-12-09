import 'package:_2geda/models/wallet_model.dart';
import 'package:_2geda/pages/walletPages/payment_success.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool showBalance = true;
  String selectedValue = ''; // Initialize with a default value
  List<String> bankList = ['Zenith', 'First Bank', 'UBA', 'Others'];
  List<Transaction> transactions = [
    Transaction(
        type: "Deposit",
        date: "Aug 2, 2023",
        amount: "- NGN 5000",
        status: "Successful"),
    Transaction(
        type: "Deposit",
        date: "Aug 2, 2023",
        amount: "- NGN 5000",
        status: "Successful"),
    Transaction(
        type: "Deposit",
        date: "Aug 2, 2023",
        amount: "- NGN 5000",
        status: "Successful"),
    Transaction(
        type: "Deposit",
        date: "Aug 2, 2023",
        amount: "- NGN 5000",
        status: "Failed"),
    Transaction(
        type: "Deposit",
        date: "Aug 2, 2023",
        amount: "- NGN 5000",
        status: "Failed"),
    Transaction(
        type: "Deposit",
        date: "Aug 2, 2023",
        amount: "- NGN 5000",
        status: "Failed"),
    Transaction(
        type: "Deposit",
        date: "Aug 2, 2023",
        amount: "- NGN 5000",
        status: "Failed"),
    // Add more transactions as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/2geda-logo.png',
              width: 40,
              height: 40,
            ),
          ),
          toolbarHeight: 80,
          backgroundColor: const Color(0xFF4E0CA2),
          title: const Text(
            'Wallet',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: Color(0xff4e0ca2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("Wallet Balance",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                showBalance = !showBalance;
                              });
                            },
                            icon: showBalance
                                ? const Icon(Icons.visibility_off,
                                    color: Colors.white)
                                : const Icon(Icons.visibility,
                                    color: Colors.white))
                      ],
                    ),
                    Text(showBalance ? "0.00" : "****",
                        style: const TextStyle(
                            fontSize: 39.11764907836914,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.add,
                                    // color: Colors,
                                  ),
                                  Text("Add money",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                showWithdrawDialog(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                    ),
                                    Text("Withdraw",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ))
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Make purchase",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                      Row(
                        children: [
                          walletCategories(
                              const Icon(Icons.event), "Event tickets"),
                          const SizedBox(
                            width: 10,
                          ),
                          walletCategories(
                              const Icon(Icons.how_to_vote), "Voting"),
                        ],
                      ),
                      Row(
                        children: [
                          walletCategories(
                              const Icon(Icons.wallet_giftcard), "Gift cards"),
                          const SizedBox(
                            width: 10,
                          ),
                          walletCategories(
                              const Icon(Icons.card_giftcard), "Gift Item"),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Transaction History",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                      for (var transaction in transactions)
                        transactionListCard(
                          transaction.type,
                          transaction.date,
                          transaction.amount,
                          transaction.status,
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/banner2.png"),
        ));
  }

  void showWithdrawDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.food_bank),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Notice: Kindly be informed that the payment will be released within 72 hours of the request. ",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text("Recipient Account",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter account number',
                    labelStyle: TextStyle(fontSize: 12),
                    // You can add more customization options here
                  ),
                  onChanged: (value) {
                    // Do something with the value entered by the user
                    print(value);
                  },
                  validator: (value) {
                    // You can add validation logic here
                    if (value!.isEmpty) {
                      return 'Please enter your account number';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                DropdownButtonFormField<String>(
                  value: null,
                  items: bankList.map((String item) {
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
                    labelText: 'Select Bank',
                    labelStyle: TextStyle(fontSize: 12),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 30, // Adjust the icon size
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                        showWithdrawDialog2(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4e0ca2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      child: const Text("Proceed",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white))),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: const Color(0xff4e0ca2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      child: const Text("Go Back",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            // color: Colors.white
                          ))),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showWithdrawDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.food_bank),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Notice: Kindly be informed that the payment will be released within 72 hours of the request. ",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text("Amount",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.money),
                    labelText: 'Enter amount to withdraw',
                    labelStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Specify the outline border color
                        width: 1.0, // Specify the outline border width
                      ),
                    ),
                    // You can add more customization options here
                  ),
                  onChanged: (value) {
                    // Do something with the value entered by the user
                    print(value);
                  },
                  validator: (value) {
                    // You can add validation logic here
                    if (value!.isEmpty) {
                      return 'Please enter amount';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentSuccess()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4e0ca2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      child: const Text("Confirm request",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                          ))),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                        showWithdrawDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: const Color(0xff4e0ca2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      child: const Text("Change withdrawal details",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            // color: Colors.white
                          ))),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDialogForInsufficient(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.error),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Payment failed",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "You have insufficient balance. Please recharge to continue your purchase.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentSuccess()),
                        );
                        Navigator.pop(
                          context,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4e0ca2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      child: const Text("Recharge",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ))),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget walletCategories(icon, String text) {
    return Expanded(
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              icon,
              Text(text,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  )),
            ],
          )),
    );
  }

  Widget transactionListCard(type, date, amount, status) {
    Color circleColor;
    Color detailColor;

    switch (type) {
      case "Deposit":
        circleColor = const Color.fromARGB(255, 30, 70, 31); // Green
        break;
      case "Withdraw":
        circleColor = Colors.orange;
        break;
      case "Ticket Purchase":
        circleColor = Colors.blue;
        break;
      case "Ticket Sold":
        circleColor = Colors.purple;
        break;
      default:
        circleColor = Colors.black; // Default color
    }

    switch (status) {
      case "Successful":
        detailColor = Colors.green;
        break;
      case "Failed":
        detailColor = Colors.red;
        break;
      case "Pending":
        detailColor = Colors.orange;
        break;
      default:
        detailColor = Colors.black; // Default color
    }

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: circleColor,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_upward,
          color: Colors.white,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: detailColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
