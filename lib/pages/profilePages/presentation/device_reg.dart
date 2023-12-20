
import 'package:_2geda/pages/profilePages/presentation/new_input.dart';
import 'package:_2geda/pages/profilePages/presentation/phone_imei.dart';
import 'package:_2geda/pages/profilePages/presentation/serial_no.dart';
import 'package:flutter/material.dart';

class DevicesReg extends StatelessWidget {
  const DevicesReg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Phone IMEI/ Gadget serial no',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PhoneImei(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Phone IMEI",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )),
                        Text("3 entries",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.red))
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SerialNo(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Serial number",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )),
                        Text("3 entries",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.red))
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed logic for the second button here
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NewInput(),
            ),
          );
        },
        backgroundColor: const Color(0xff4e0ca2),
        child: const Icon(Icons.add),
      ),
    );
  }
}
