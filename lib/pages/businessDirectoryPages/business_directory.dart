import 'package:_2geda/data/business_data.dart';
import 'package:_2geda/models/business_model.dart';
import 'package:_2geda/pages/businessDirectoryPages/claim_business.dart';
import 'package:_2geda/pages/widgets/businessDir/business_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BusinessDirectory extends StatefulWidget {
  const BusinessDirectory({super.key});

  @override
  State<BusinessDirectory> createState() => _BusinessDirectoryState();
}

class _BusinessDirectoryState extends State<BusinessDirectory> {
  String selectedValue = 'Most Popular';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/2geda-purple.png',
            width: 40,
            height: 40,
          ),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        title: const Text(
          'Business Directory',
          style: TextStyle(color: Color(0xff4e0ca2)),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    // Wrap the TextFormField with Expanded
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.search), // Icon as a prefix
                        hintText: 'Find business', // Placeholder text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the radius as needed
                          borderSide: const BorderSide(
                            width: 2, // Set the border width
                          ),
                        ),
                      ),
                      // Add any other properties and handlers as needed
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1)),
                    child: IconButton(
                      icon: const Icon(Icons.sort),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/banner2.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              const BusinessListWidget(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Top businesses",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  DropdownButton<String>(
                    value: selectedValue,
                    items: <String>['Most Popular', 'Claimed', 'Unclaimed']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 10, // Set the desired font size
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  for (Business business in businesses)
                    BusinessCard(business: business),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessCard extends StatelessWidget {
  final Business business;

  BusinessCard({required this.business});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 138, 21, 1),

          border: Border.all(
            color: const Color(0xff4e0ca2), // You can use any color you like
            width: 2.0, // Adjust the width as needed
          ),
          borderRadius:
              BorderRadius.circular(12.0), // Adjust the radius as needed
        ),
        child: Card(
          color: const Color.fromRGBO(255, 138, 21, 1),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Business Logo (if available)

                // Business Name
                Row(
                  children: [
                    // Business Logo (if available)
                    if (business.logo != null)
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(business.logo!),
                            fit: BoxFit
                                .cover, // You can choose the fit mode you prefer
                          ),
                        ),
                      ),

                    // Business Icon (if logo is null)
                    if (business.logo == null)
                      const Icon(
                        Icons.business,
                        size: 50,
                        color: Colors.black, // Customize the icon color
                      ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          business.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          business.address,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Business Description
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    business.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(100, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.mail,
                            size: 20,
                            color: Color(0xff4e0ca2),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Mail",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff4e0ca2),
                              )),
                        ],
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(100, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.call,
                            size: 20,
                            color: Color(0xff4e0ca2),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Call",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff4e0ca2),
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(100, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.view_agenda,
                            size: 20,
                            color: Color(0xff4e0ca2),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("View",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff4e0ca2),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ClaimBusinessPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(150, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Claim business",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4e0ca2),
                        minimumSize: const Size(150, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Visit page",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
