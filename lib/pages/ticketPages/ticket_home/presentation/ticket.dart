
import 'package:_2geda/pages/ticketPages/buyTicket/presentation/buy_ticket.dart';
import 'package:_2geda/pages/ticketPages/sellTicket/presentation/sell_ticket.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: TicketPage(),
  ));
}

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/2geda-purple.png'),
        ),
        title: const Text(
          'Tickets',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                "What would you like to do?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BuyTicketPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: 159,
                      height: 200,
                      decoration: BoxDecoration(
                          color: const Color(0xff4e0ca2),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/buy_ticket.png',
                            width: 90,
                            height: 90,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Buy ticket",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SellTicketPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: 159,
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: const Color(0xff4e0ca2)),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/sell_ticket.png',
                            width: 90,
                            height: 90,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Sell ticket",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) =>
              //             const BuyTicketPage(),
              //       ),
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: const Color(0xff4e0ca2),
              //     minimumSize: const Size(500, 60),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   child: const Text(
              //     "Continue",
              //     style: TextStyle(
              //       fontSize: 17,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
