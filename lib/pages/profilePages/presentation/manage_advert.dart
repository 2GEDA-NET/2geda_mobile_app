
import 'package:_2geda/pages/profilePages/presentation/advert_policy.dart';
import 'package:flutter/material.dart';

class ManageAdvert extends StatelessWidget {
  const ManageAdvert({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Manage Advert',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("You do not have an active Advert",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                )),
          ),
          const Text("Read our Ad Policy",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w300,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdvertPolicy(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4e0ca2),
                minimumSize: const Size(300, 60),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(1),
                // ),
              ),
              child: const Text(
                "Post an Advert",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
