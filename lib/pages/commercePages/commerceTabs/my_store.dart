// account_screen.dart

import 'package:_2geda/pages/commercePages/commerceSearch/product_search_grid.dart';
import 'package:_2geda/pages/commercePages/sellAnItem/sell_an_item.dart';
import 'package:flutter/material.dart';

class MyStorePage extends StatelessWidget {
  const MyStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'My Store',
          style: TextStyle(color: Color(0xff4e0ca2)),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SellAnItemPage(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProductGridList(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/banner.png'),
            ),
            const ProductGridList()
          ],
        ),
      ),
    );
  }
}
