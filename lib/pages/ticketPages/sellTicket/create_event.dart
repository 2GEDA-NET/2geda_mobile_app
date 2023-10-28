import 'package:_2geda/pages/ticketPages/sellTicket/success_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CreateTicketPage(),
    );
  }
}

class CreateTicketPage extends StatefulWidget {
  const CreateTicketPage({super.key});

  @override
  _CreateTicketPageState createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  int currentStep = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Create Event',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              type: StepperType.horizontal,
              elevation: 0,
              currentStep: currentStep,
              onStepTapped: (step) {
                setState(() {
                  currentStep = step;
                });
              },
              onStepContinue: () {
                if (currentStep < 2) {
                  setState(() {
                    currentStep += 1;
                  });
                } else {
                  // Handle form submission, e.g., save data
                  if (formKey.currentState!.validate()) {
                    // Process the form data, e.g., submit to an API
                    // Reset the form
                    formKey.currentState!.reset();
                    titleController.clear();
                    descriptionController.clear();
                    setState(() {
                      currentStep = 0;
                    });
                    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //   content: Text('Ticket submitted!'),
                    // ));

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SuccessPage()));
       
                  }
                }
              },
              onStepCancel: () {
                if (currentStep > 0) {
                  setState(() {
                    currentStep -= 1;
                  });
                }
              },
              steps: [
                Step(
                  title: const Text(
                    "Event info",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  content: EventInfoStep(
                    formKey: formKey,
                    titleController: titleController,
                    descriptionController: descriptionController,
                    currentStep: currentStep,
                  ),
                  isActive: currentStep == 0,
                ),
                Step(
                  title: const Text(
                    "Create ticket",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  content: const CreateTicketStep(),
                  isActive: currentStep == 1,
                ),
                Step(
                  title: const Text(
                    "Additional info",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  content: const AdditionalInfoStep(),
                  isActive: currentStep == 2,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/banner2.png'),
          ),
        ],
      ),
    );
  }
}

class EventInfoStep extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final int currentStep;

  EventInfoStep({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.currentStep,
  });

  @override
  State<EventInfoStep> createState() => _EventInfoStepState();
}

class _EventInfoStepState extends State<EventInfoStep> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Event info",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  )),
              Text("Tell us a bit about your event",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              labelText: 'Event title', // Label text for the input field
              hintStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
              hintText:
                  'Enter your event title. Make it clear and concise', // Hint text for the input field
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
                return 'Please enter your event title';
              }
              // You can add more validation logic here as needed
              return null; // Return null if validation passes
            },
          ),
          const Text("0/50 words",
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w400,
              )),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            maxLines: 5,
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              labelText: 'Event description', // Label text for the input field
              hintStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
              hintText:
                  'Enter your event details. It may contain FAQs and what attendees should expect from the event', // Hint text for the input field
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
                return 'Please enter your event title';
              }
              // You can add more validation logic here as needed
              return null; // Return null if validation passes
            },
          ),
          // TextFormField(
          //   controller: titleController,
          //   decoration: InputDecoration(labelText: 'Title'),
          //   validator: (value) {
          //     if (value!.isEmpty) {
          //       return 'Please enter a title';
          //     }
          //     return null;
          //   },
          // ),
          // TextFormField(
          //   controller: descriptionController,
          //   decoration: InputDecoration(labelText: 'Description'),
          //   validator: (value) {
          //     if (value!.isEmpty) {
          //       return 'Please enter a description';
          //     }
          //     return null;
          //   },
          // ),

          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              labelText: 'Platform name', // Label text for the input field
              hintStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
              hintText:
                  'skype, google meet, webinar, etc.', // Hint text for the input field
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
                return 'Please enter your event venue';
              }
              // You can add more validation logic here as needed
              return null; // Return null if validation passes
            },
          ),
          const SizedBox(
            height: 10,
          ),
          _uploadImage(),
          TextButton(
            onPressed: () {},
            child: const Row(
              children: [
                Icon(Icons.location_on),
                Text("Set location",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    )),
              ],
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              labelText:
                  'Website link or URL', // Label text for the input field
              hintStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
              hintText:
                  'https://www.example.com', // Hint text for the input field
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
                return 'Please enter your website link or URL';
              }
              // You can add more validation logic here as needed
              return null; // Return null if validation passes
            },
          ),
        ],
      ),
    );
  }

  Widget _uploadImage() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        width: 1,
      )),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.upload_file,
            ),
          ),
          const Text("Upload event image",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )),
          const Text(
              textAlign: TextAlign.center,
              "Upload a compelling image. We recommend using at least a 2160x1080px (2:1 ratio) image that's no larger than 10MB",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              )),
        ],
      ),
    );
  }
}

class CreateTicketStep extends StatefulWidget {
  const CreateTicketStep({super.key});

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
    return Column(
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
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              TextFormField(
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
                children: [
                  Expanded(
                    child: TextFormField(
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
                  ),
                  const Spacer(),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
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
                        hintText: _selection[0] ? 'FREE TICKET' : 'PAID TICKET',
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
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Event category",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            )),
        SizedBox(
          height: 5,
        ),
        InputDecorator(
          decoration: const InputDecoration(
            hintText: 'Select an option', // Label text
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
    );
  }
}

class AdditionalInfoStep extends StatefulWidget {
  const AdditionalInfoStep({super.key});

  @override
  State<AdditionalInfoStep> createState() => _AdditionalInfoStepState();
}

class _AdditionalInfoStepState extends State<AdditionalInfoStep> {
  bool _showRemaningTicket = false; // Define the 'value' variable
  bool _isPublic = false; // Define the 'value' variable
  bool _isPrivate = false; // Define the 'value' variable
  String selectedValue = 'Option 1';
  // Initial value
  List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Additional information",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            )),
        const Text("Tell us a bit more about your event",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            )),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Show remaining tickets",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
                  Text("Show the number of remaining tickets on your events",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
            ),
            Switch(
              value: _showRemaningTicket,
              onChanged: (newValue) {
                // You can handle the onChanged event here
                setState(() {
                  _showRemaningTicket = newValue;
                });
              },
            ),
          ],
        ),
        const Divider(),
        const SizedBox(
          height: 5,
        ),
        const Text("Event Listing Privacy",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            )),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Public",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
                Text(
                    "Your event can be found by anyone on our app, our\npromotion partners, and search engines",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ))
              ],
            ),
            Switch(
              value: _isPublic,
              onChanged: (newValue) {
                // You can handle the onChanged event here
                setState(() {
                  _isPublic = newValue;
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Private",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
                Text("Only people you share invite link can find your event",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ))
              ],
            ),
            Switch(
              value: _isPrivate,
              onChanged: (newValue) {
                // You can handle the onChanged event here
                setState(() {
                  _isPrivate = newValue;
                });
              },
            ),
          ],
        ),
        const Divider(),
        const SizedBox(
          height: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Fees settings",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(
              height: 5,
            ),
            const Text(
                "Please specify if transaction fees would be passed on to buyers or charged from your account. We charge 5% + N200.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(
              height: 5,
            ),
            InputDecorator(
              decoration: const InputDecoration(
                hintText: 'Select an option', // Label text
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
          ],
        )
      ],
    );
  }
}
