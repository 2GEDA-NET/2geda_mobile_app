import 'package:_2geda/pages/commercePages/sellAnItem/upload_image.dart';
import 'package:flutter/material.dart';

class SellAnItemPage extends StatefulWidget {
  
  SellAnItemPage({super.key});

  @override
  State<SellAnItemPage> createState() => _SellAnItemPageState();
}

class _SellAnItemPageState extends State<SellAnItemPage> {
  TextEditingController productNameController = TextEditingController();

  TextEditingController productDescriptionController = TextEditingController();

  List<String> currencyOptions = ['USD', 'EUR', 'GBP', 'JPY', 'AUD'];

  String selectedCurrency = 'USD';
  // Set an initial selected currency
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Sell an item',
          style: TextStyle(color: Color(0xff4e0ca2)),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.shop_two,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sell any item in 3 simple steps",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the radius as needed
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Set Product Category",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: productNameController,
                style: const TextStyle(
                  fontSize: 13,
                ),
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  hintText: 'Enter the product name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null; // Return null for no validation errors
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: productDescriptionController,
                style: const TextStyle(
                  fontSize: 13,
                ),
                decoration: const InputDecoration(
                  labelText: 'Product Description',
                  hintText: 'Enter the product description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4, // Allowing multiple lines for description
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a product description';
                  }
                  return null; // Return null for no validation errors
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the radius as needed
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Set Sale location",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        )),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the radius as needed
                ),
                child: Row(
                  children: [
                    const Text(
                      "Item Price",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                        width: 10), // Add spacing between label and dropdown
                    DropdownButton<String>(
                      value: selectedCurrency,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                      items: currencyOptions.map((String currency) {
                        return DropdownMenuItem<String>(
                          value: currency,
                          child: Text(currency),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCurrency = newValue!;
                        });
                      },
                    ),
                    const SizedBox(
                        width:
                            10), // Add spacing between dropdown and text field
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Price',
                          border: InputBorder
                              .none, // Remove the border of the TextField
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xffe3c0ff),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Read our Pricing Guidelines",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        size: 17,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xffe3c0ff),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("How to sell faster",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward,
                          size: 17,
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductImageUpload(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  minimumSize: const Size(500, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Move to step 2",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
