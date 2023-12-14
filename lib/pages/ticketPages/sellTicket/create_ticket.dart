import 'package:flutter/material.dart';

class CreateTicketStep extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final TextEditingController priceController;
  final TextEditingController freeTicketController;
  final TextEditingController paidTicketController;

  const CreateTicketStep({
    Key? key, // Add a key parameter to the constructor
    required this.formKey,
    required this.nameController,
    required this.quantityController,
    required this.priceController,
    required this.freeTicketController,
    required this.paidTicketController,
  }) : super(key: key); // Use the key parameter to initialize the super class

  @override
  State<CreateTicketStep> createState() => _CreateTicketStepState();
}

class _CreateTicketStepState extends State<CreateTicketStep> {
  final List<bool> _selection = [true, false];

  List<TicketFormData> _ticketForms = [
    TicketFormData()
  ]; // Initialize with one form
  void _addTicketForm() {
    setState(() {
      _ticketForms.add(TicketFormData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Render ticket forms dynamically based on the length of _ticketForms
          for (int i = 0; i < _ticketForms.length; i++)
            TicketForm(
              ticketFormData: _ticketForms[i],
              onDelete: () {
                setState(() {
                  _ticketForms.removeAt(i);
                });
              },
              getSelectedController: _getSelectedController,
              isSelected: _selection[0],
              onSelectionChanged: (bool isSelected1, bool isSelected2) {
                setState(() {
                  _selection[0] = isSelected1;
                  _selection[1] = isSelected2;
                });
              },
              onAdd: () {
                setState(() {
                  _ticketForms.add(i as TicketFormData);
                });
              },
            ),

          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  TextEditingController _getSelectedController() {
    return _selection[0]
        ? widget.freeTicketController
        : widget.paidTicketController;
  }
}

class TicketFormData {
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController freeTicketController = TextEditingController();
  TextEditingController paidTicketController = TextEditingController();
}

class TicketForm extends StatelessWidget {
  final TicketFormData ticketFormData;
  final VoidCallback onDelete;
  final VoidCallback onAdd;
  final TextEditingController Function() getSelectedController;
  final bool isSelected;
  final Function(bool, bool) onSelectionChanged; // Add this callback

  const TicketForm({
    Key? key,
    required this.ticketFormData,
    required this.onDelete,
    required this.onAdd,
    required this.getSelectedController,
    required this.isSelected,
    required this.onSelectionChanged, // Pass the callback through the constructor
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onSelectionChanged(
                        true, false); // Notify the parent about the change
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
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
                    onSelectionChanged(
                        false, true); // Notify the parent about the change
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
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
                controller: ticketFormData.nameController,
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
                      controller: ticketFormData.quantityController,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        labelText: 'Quantity', // Label text for the input field
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
                      controller: TextEditingController(
                          text: getSelectedController().text),
                      readOnly: isSelected ? true : false,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        labelText: 'Price', // Label text for the input field
                        hintText: isSelected ? 'FREE TICKET' : 'PAID TICKET',
                        hintStyle: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
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
                  ElevatedButton(
                    onPressed: onAdd,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: const Text("Add",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: onDelete,
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
      ],
    );
  }
}
