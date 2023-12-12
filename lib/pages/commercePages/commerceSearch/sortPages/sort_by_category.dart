// account_screen.dart

import 'package:flutter/material.dart';

class SortByCategory extends StatelessWidget{
  const SortByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sort By Category', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Center(
              child: Text('Account Screen Content'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.7,),
            ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4e0ca2),
                    minimumSize: const Size(500, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Apply",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
