import 'package:_2geda/pages/ticketPages/search_result/presentation/search_result.dart';
import 'package:flutter/material.dart';

class SearchTicketPage extends StatefulWidget {
  const SearchTicketPage({super.key});

  @override
  State<SearchTicketPage> createState() => _SearchTicketPageState();
}

class _SearchTicketPageState extends State<SearchTicketPage> {
  String selectedValue = 'Option 1';
  // Initial value
  List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Find great events around you.\nAnytime! Anywhere!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter name', // Label text for the input field
                  prefixIcon: const Icon(Icons.title),
                  hintText: 'Enter your name', // Hint text for the input field
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Set the border radius to 8
                  ), // Add a border to the input field
                ),
      
                keyboardType:
                    TextInputType.text, // Set the keyboard type to email address
                validator: (value) {
                  // Add email validation logic here (e.g., check if it's a valid email)
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  // You can add more validation logic here as needed
                  return null; // Return null if validation passes
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InputDecorator(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.category),
                  hintText: 'Select an category', // Label text
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: dropdownItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InputDecorator(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_city),
                  hintText: 'All City', // Label text
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: dropdownItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Everytime', // Label text for the input field
                  prefixIcon: const Icon(Icons.lock_clock),
                  hintText: 'Enter your name', // Hint text for the input field
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Set the border radius to 8
                  ), // Add a border to the input field
                ),
      
                keyboardType:
                    TextInputType.text, // Set the keyboard type to email address
                validator: (value) {
                  // Add email validation logic here (e.g., check if it's a valid email)
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  // You can add more validation logic here as needed
                  return null; // Return null if validation passes
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter value', // Label text for the input field
                  prefixIcon: const Icon(Icons.location_pin),
                  hintText: 'Enter your name', // Hint text for the input field
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Set the border radius to 8
                  ), // Add a border to the input field
                ),
      
                keyboardType:
                    TextInputType.text, // Set the keyboard type to email address
                validator: (value) {
                  // Add email validation logic here (e.g., check if it's a valid email)
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  // You can add more validation logic here as needed
                  return null; // Return null if validation passes
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const SearchResultPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(500, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Find events",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/banner2.png'),
            )
            ],
          ),
        ),
      ),
    );
  }
}
