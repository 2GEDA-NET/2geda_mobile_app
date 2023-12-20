import 'package:_2geda/data/payment_data.dart';
import 'package:_2geda/models/wallet_model.dart';
import 'package:flutter/material.dart';

class RewardHistory extends StatefulWidget {
  const RewardHistory({super.key});

  @override
  State<RewardHistory> createState() => _RewardHistoryState();
}

class _RewardHistoryState extends State<RewardHistory> {
  String? selectedValue;
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

  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec',
  ];

  void _showMonthPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              for (var month in months)
                ListTile(
                  title: Text(month),
                  onTap: () {
                    setState(() {
                      selectedValue = month;
                    });
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                )),
            title: const Text(
              'History',
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    _showMonthPicker(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selectedValue ?? 'Select a Month',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
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
        ));
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

  Widget _paymentList() {
    return SingleChildScrollView(
      child: Column(
        children: paymentData.map((payment) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            payment.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            payment.timestamp,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            (payment.amount < 0
                                ? "-\$${(-payment.amount).toStringAsFixed(2)}"
                                : "\$${payment.amount.toStringAsFixed(2)}"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            payment.status,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          );
        }).toList(),
      ),
    );
  }
}
