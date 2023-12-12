// import 'package:flutter/material.dart';

// class ProductPreviewPage extends StatelessWidget {
//   // final String productName;
//   // final String productDescription;
//   // final String selectedCurrency;

//   // ProductPreviewPage({
//   //   required this.productName,
//   //   required this.productDescription,
//   //   required this.selectedCurrency,
//   // });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Preview Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Product Name: $productName',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Product Description: $productDescription',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Selected Currency: $selectedCurrency',
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// // ElevatedButton(
// //   onPressed: () {
// //     final productName = productNameController.text;
// //     final productDescription = productDescriptionController.text;
// //     // Pass the selected data to the PreviewPage
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => PreviewPage(
// //           productName: productName,
// //           productDescription: productDescription,
// //           selectedCurrency: selectedCurrency,
// //         ),
// //       ),
// //     );
// //   },
// //   style: ElevatedButton.styleFrom(
// //     backgroundColor: const Color(0xff4e0ca2),
// //     minimumSize: const Size(500, 60),
// //     shape: RoundedRectangleBorder(
// //       borderRadius: BorderRadius.circular(10),
// //     ),
// //   ),
// //   child: const Text("Preview",
// //       style: TextStyle(
// //         fontSize: 15,
// //         fontWeight: FontWeight.w400,
// //       )),
// // ),


import 'package:_2geda/pages/commercePages/sellAnItem/product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductPreviewPage extends StatefulWidget {

  const ProductPreviewPage({super.key, });

  @override
  State<ProductPreviewPage> createState() => _ProductPreviewPageState();
}

class _ProductPreviewPageState extends State<ProductPreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Product Preview',
          style: TextStyle(color: Color(0xff4e0ca2)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
                fit: BoxFit.cover,
                height: 235,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color(0xff4e0ca2),
                    borderRadius: BorderRadius.circular(10)),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Automobile',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '\$ 20000',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lexus',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Sale Location : Lekki, Lagos",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 150,
                      child: const Text(
                          "Newly used Toyota venza | V6 engine | Full option Custom duty and Fully registered. Average speed 245km/sec, Auto and Manual transmission for Sport mode.",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ProductDetails(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffff8a15),
                          minimumSize: const Size(500, 60),
                          
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          "Publish this item",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
             ],
          ),
        ),
      ),
    );
  }
}
