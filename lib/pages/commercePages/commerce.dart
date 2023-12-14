import 'package:_2geda/pages/commercePages/cart_page.dart';
import 'package:_2geda/pages/commercePages/commerceTabs/manage_stores.dart';
import 'package:_2geda/pages/commercePages/commerceSearch/product_search.dart';
import 'package:_2geda/pages/commercePages/commerceTabs/top_products.dart';
import 'package:_2geda/pages/widgets/product/product_widget.dart';
import 'package:flutter/material.dart';

class CommerceScreen extends StatelessWidget {
  const CommerceScreen({Key? key});

  

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
        backgroundColor: Color(0xFF4E0CA2),
        title: const Text('Commerce', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 1,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white,),
            onPressed: () {
              // Handle the search action
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white,),
            onPressed: () {
              // Handle the notifications action
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductSearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xff4e0ca2),
              ),
              child: const ProductCategoryList(),
            ),
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    dividerColor: Colors.white,
                    indicator: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              10.0), // Set your desired border radius for the top-left corner
                          bottomRight: Radius.circular(
                              10.0), // Set your desired border radius for the top-right corner
                        ),
                      ),
                      color: Color(
                          0xffff8a15), // Set your desired background color for the active tab
                    ),
                    labelColor:
                        Colors.white, // Set the text color for the active tab
                    unselectedLabelColor: Colors
                        .black, // Set the text color for the unselected tab
                    tabs: [
                      Tab(
                        child: Text(
                          'Top Product',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Manage Store',
                        ),
                      ),
                    ],
                  ),
                  // Use a SizedBox to set a constant height for TabBarView
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: TabBarView(
                      children: [
                        ListView(
                          children: [
                            // Content for the "Sell an Item" tab
                            TopProductsTab(),
                          ],
                        ),
                        ListView(
                          children: [
                            // Content for the "Manage Store" tab
                            ManageStoreTab(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
