import 'package:_2geda/pages/profilePages/new_input.dart';
import 'package:_2geda/pages/profilePages/phone_imei.dart';
import 'package:flutter/material.dart';

class SerialNo extends StatelessWidget {
  const SerialNo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Serial IMEI',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              DeviceCard(
                deviceName: 'Phone 1',
                deviceNo: '#34567345679864432345569097',
              ),
              DeviceCard(
                deviceName: 'Phone 1',
                deviceNo: '#34567345679864432345569097',
              ),
              DeviceCard(
                deviceName: 'Phone 1',
                deviceNo: '#34567345679864432345569097',
              ),
            ],
          ),
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
