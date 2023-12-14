import 'package:flutter/material.dart';

class CreateTicketStep extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final TextEditingController priceController;
  final TextEditingController categoryController;
  final TextEditingController freeTicketController;
  final TextEditingController paidTicketController;

  const CreateTicketStep({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.quantityController,
    required this.priceController,
    required this.categoryController,
    required this.freeTicketController,
    required this.paidTicketController,
  });

  @override
  State<CreateTicketStep> createState() => _CreateTicketStepState();
}

class _CreateTicketStepState extends State<CreateTicketStep> {
  final List<bool> _selection = [true, false];
  String selectedValue = 'Option 1';
  // Initial value
  List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Create ticket",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )),
          const Text("Create ticket type(s) you want for this event",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )),
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selection[0] = true;
                        _selection[1] = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selection[0]
                            ? const Color.fromRGBO(230, 210, 255, 1.0)
                            : Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(Icons.add),
                            Text(
                              "Free ticket",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selection[0] = false;
                        _selection[1] = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selection[1]
                            ? const Color.fromRGBO(230, 210, 255, 1.0)
                            : Colors.white,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(Icons.add),
                            Text(
                              "Paid ticket",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                TextFormField(
                  controller: widget.nameController,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    labelText: 'Ticket name', // Label text for the input field
                    hintStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                    hintText:
                        'e.g early bird, regular, etc', // Hint text for the input field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Set the border radius to 8
                    ), // Add a border to the input field
                  ),
                  keyboardType: TextInputType
                      .text, // Set the keyboard type to email address
                  validator: (value) {
                    // Add email validation logic here (e.g., check if it's a valid email)
                    if (value == null || value.isEmpty) {
                      return 'Please enter your ticket name';
                    }
                    // You can add more validation logic here as needed
                    return null; // Return null if validation passes
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: widget.quantityController,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          labelText:
                              'Quantity', // Label text for the input field
                          hintStyle: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                          hintText:
                              'e.g 1, 2, 3, etc', // Hint text for the input field
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Set the border radius to 8
                          ), // Add a border to the input field
                        ),
                        keyboardType: TextInputType
                            .number, // Set the keyboard type to email address
                        validator: (value) {
                          // Add email validation logic here (e.g., check if it's a valid email)
                          if (value == null || value.isEmpty) {
                            return 'Please enter your quantity';
                          }
                          // You can add more validation logic here as needed
                          return null; // Return null if validation passes
                        },
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: TextFormField(
                        controller: _getSelectedController(),
                        readOnly: _selection[0] ? true : false,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          labelText: 'Price', // Label text for the input field
                          hintStyle: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                          hintText:
                              _selection[0] ? 'FREE TICKET' : 'PAID TICKET',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the price';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      child: const Text("Delete",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Event category",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              )),
          const SizedBox(
            height: 5,
          ),
          InputDecorator(
            decoration: const InputDecoration(
              hintText: 'Select a category', // Label text
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
                  fontWeight: FontWeight.w400,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.categoryController.text = newValue!;
                  });
                },
                items:
                    dropdownItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // New method to return the selected controller
  TextEditingController _getSelectedController() {
    return _selection[0]
        ? widget.freeTicketController
        : widget.paidTicketController;
  }
}
