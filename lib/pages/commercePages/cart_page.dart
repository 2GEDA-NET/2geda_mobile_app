import 'package:_2geda/data/product_data.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart', style: TextStyle(color: Colors.black)),
        iconTheme:
            const IconThemeData(color: Colors.black), // Set the icon color
        backgroundColor: Colors.white, // Set the background color
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: Container(
                          width: 60, // Adjust the image width as needed
                          height: 60, // Adjust the image height as needed
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius as needed
                            image: DecorationImage(
                              image: NetworkImage(item.product.image),
                              fit: BoxFit
                                  .cover, // You can adjust the fit as needed
                            ),
                          ),
                        ),
                        title: Text(
                          item.product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$${item.product.price}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(item.product.location,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                )),
                          ],
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment
                            .spaceBetween, // Adjust the alignment as needed

                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.red, // Set the background color to red
                              minimumSize:
                                  const Size(150, 40), // Set the desired size
                            ),
                            child: const Text(
                              "Remove item",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(150,
                                  40), // Set the same size as the first button
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Message seller",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.chat_bubble,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(
      const MaterialApp(
        home: CartPage(),
      ),
    );
