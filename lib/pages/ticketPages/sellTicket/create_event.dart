import 'package:_2geda/APIServices/event_api_service.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/ticketPages/sellTicket/addition_info.dart';
import 'package:_2geda/pages/ticketPages/sellTicket/create_ticket.dart';
import 'package:_2geda/pages/ticketPages/sellTicket/event_info.dart';
import 'package:_2geda/pages/ticketPages/sellTicket/success_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

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
  final TokenManager tokenManager = TokenManager();
  String? authToken;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<TicketFormData> _ticketForms = [];

  final GlobalKey<FormState> createTicketFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> eventInfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addInfoFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController platformController = TextEditingController();
  TextEditingController websiteUrlController = TextEditingController();
  final TicketApiService apiService = TicketApiService();
  TextEditingController imageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController freeTicketController = TextEditingController();
  TextEditingController paidTicketController = TextEditingController();

  TextEditingController categoryController = TextEditingController();
  TextEditingController feeSettingCategoryController = TextEditingController();
  TextEditingController showRemainingTicketController = TextEditingController();
  TextEditingController isPrivateController = TextEditingController();
  TextEditingController isPublicController = TextEditingController();
  late LatLng selectedLocation = const LatLng(0.0, 0.0);
  String selectedValue = 'Festival';
  List<String> dropdownItems = [
    'Festival',
    'Food and drinks',
    'Fashion',
    'Others'
  ];

  XFile? _selectedImage = XFile('');

  @override
  void initState() {
    super.initState();
    _loadAuthToken();
    // Initialize authToken using the TokenManager or any other method
  }

  _loadAuthToken() async {
    authToken = await tokenManager.getToken();
    print('Auth Token: $authToken');
    print('Token $authToken');
  }

  void _submitForm() async {
    // Validate each form separately
    bool eventInfoValid = eventInfoFormKey.currentState?.validate() ?? false;
    bool createTicketValid =
        createTicketFormKey.currentState?.validate() ?? false;
    bool addInfoValid = addInfoFormKey.currentState?.validate() ?? false;

    // Check if all forms are valid
    if (eventInfoValid && createTicketValid && addInfoValid) {
      // Process the form data, e.g., submit to an API
      // Reset the forms
      eventInfoFormKey.currentState!.reset();
      createTicketFormKey.currentState!.reset();
      addInfoFormKey.currentState!.reset();
      // titleController.clear();
      // descriptionController.clear();
      // platformController.clear();
      // websiteUrlController.clear();
      // nameController.clear();
      // priceController.clear();
      // categoryController.clear();
      // locationController.clear();
      // feeSettingCategoryController.clear();
      // isPrivateController.clear();
      // isPublicController.clear();
      // showRemainingTicketController.clear();
      // Clear other controllers as needed

      setState(() {
        currentStep = 0;
      });

      print('Auth Token: $authToken');

      // Ensure _selectedImage is not null before using it
      if (_selectedImage != null) {
        XFile? selectedImageFile =
            _selectedImage != null ? XFile(_selectedImage!.path) : null;
        // Use the ApiService to submit the form data
        bool success = await apiService.createEvent(
          title: titleController.text,
          description: descriptionController.text,
          platform: platformController.text,
          websiteUrl: websiteUrlController.text,
          selectedImage: selectedImageFile,
          location: selectedLocation,
          ticketName: nameController.text,
          quantity: quantityController.text.isNotEmpty
              ? int.parse(quantityController.text)
              : 0,
          price: priceController.text,
          category: categoryController.text,
          address: locationController.text,
          feeSettingCategory: feeSettingCategoryController.text,
          isPrivate: isPrivateController.text.toLowerCase() == 'true',
          isPublic: isPublicController.text.toLowerCase() == 'true',
          showRemainingTicket:
              showRemainingTicketController.text.toLowerCase() == 'true',
          authToken: authToken!,
          isFree: freeTicketController.text.toLowerCase() == 'true',
          isPaid: freeTicketController.text.toLowerCase() == 'true',

          // Add other necessary form fields
        );

        if (success) {
          // Form submission successful, navigate to success page
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SuccessPage()),
          );
        } else {
          // Form submission failed, show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error submitting form. Please try again.'),
            ),
          );
        }
      } else {
        // Handle the case when _selectedImage is null
        print('Selected Image is null');
      }
    }
  }

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
                  _submitForm();
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
                    formKey: eventInfoFormKey,
                    titleController: titleController,
                    descriptionController: descriptionController,
                    platformController: platformController,
                    websiteUrlController: websiteUrlController,
                    imageController: imageController,
                    currentStep: currentStep,
                    onImageSelected: (XFile? selectedImage) {
                      // Handle the selected image here
                      setState(() {
                        _selectedImage = selectedImage!;
                      });
                    },
                    selectedLocation: selectedLocation,
                    locationController: locationController,
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
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Create ticket",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text(
                        "Create ticket type(s) you want for this event",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: ListView.builder(
                          itemCount: _ticketForms.length,
                          itemBuilder: (context, index) {
                            return CreateTicketStep(
                              key: UniqueKey(),
                              formKey: GlobalKey<FormState>(),
                              nameController:
                                  _ticketForms[index].nameController,
                              quantityController:
                                  _ticketForms[index].quantityController,
                              priceController:
                                  _ticketForms[index].priceController,
                              freeTicketController:
                                  _ticketForms[index].freeTicketController,
                              paidTicketController:
                                  _ticketForms[index].paidTicketController,
                            );
                          },
                        ),
                      ),
                      const Text(
                        "Event category",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InputDecorator(
                        decoration: const InputDecoration(
                          hintText: 'Select a category', // Label text
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                                categoryController.text = newValue!;
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
                  ),
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
                  content: AdditionalInfoStep(
                    formKey: addInfoFormKey,
                    feeSettingCategoryController: feeSettingCategoryController,
                    showRemainingTicketController:
                        showRemainingTicketController,
                    isPublicController: isPublicController,
                    isPrivateController: isPrivateController,
                  ),
                  isActive: currentStep == 2,
                ),
              ],
            ),
          ),
          // const SizedBox(height: 10),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Image.asset('assets/banner2.png'),
          // ),
        ],
      ),
    );
  }
}
