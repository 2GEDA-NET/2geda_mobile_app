import 'package:flutter/material.dart';
import 'package:_2geda/data/product_data.dart';
import 'package:_2geda/pages/widgets/product/product_widget.dart';

class ProductGridList extends StatelessWidget {
  const ProductGridList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical, // Scroll vertically
      child: Row(
        children: [
          for (int i = 0; i < productList.length; i += 2)
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.5, // Set the width as half of the screen width
                  child: ProductCardWidget(product: productList[i]),
                ),
                if (i + 1 < productList.length)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ProductCardWidget(product: productList[i + 1]),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
