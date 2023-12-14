import 'package:_2geda/pages/businessDirectoryPages/confirmation_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ClaimBusinessForm extends StatefulWidget {
  const ClaimBusinessForm({super.key});

  @override
  _ClaimBusinessFormState createState() => _ClaimBusinessFormState();
}

class _ClaimBusinessFormState extends State<ClaimBusinessForm> {
  int _currentPage = 0; // Track the current page
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Claim Business',
          style: TextStyle(color: Color(0xff4e0ca2)),
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
            child: PageView(
              controller: _pageController, // Add this line
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                BusinessInformationSection(
                  currentPage: _currentPage,
                  pageController: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                ),
                DocumentDetailsSection(
                  currentPage: _currentPage,
                  pageController: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                ),
                ContactInformationSection(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                HorizontalLine(currentPage: _currentPage, pageIndex: 0),
                HorizontalLine(currentPage: _currentPage, pageIndex: 1),
                HorizontalLine(currentPage: _currentPage, pageIndex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalLine extends StatelessWidget {
  final int currentPage;
  final int pageIndex;

  const HorizontalLine(
      {super.key, required this.currentPage, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Adjust the width as needed
      height: 5, // Adjust the height as needed
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30), // Adjust the radius as needed
        color: currentPage >= pageIndex ? const Color(0xff4e0ca2) : Colors.grey,
      ),
    );
  }
}

class BusinessInformationSection extends StatefulWidget {
  final int currentPage;
  final PageController pageController;
  final Function(int) onPageChanged;

  const BusinessInformationSection({
    super.key,
    required this.currentPage,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  State<BusinessInformationSection> createState() =>
      _BusinessInformationSectionState();
}

class _BusinessInformationSectionState
    extends State<BusinessInformationSection> {
  String initialCountry = 'US';

  PhoneNumber number = PhoneNumber(isoCode: 'US');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Provide business information",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                "Enter business details for ownership claim",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Business name",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter business name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Specify the outline border color
                      width: 1.0, // Specify the outline border width
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Business address",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter business address',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Specify the outline border color
                      width: 1.0, // Specify the outline border width
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Business description",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  hintText: 'Start typing',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Specify the outline border color
                      width: 1.0, // Specify the outline border width
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Phone number",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius:
                      BorderRadius.circular(8.0), // Add rounded corners
                ),
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DROPDOWN,
                  ),
                  onInputValidated: (bool value) {
                    // Validation logic can go here
                  },
                  inputDecoration: const InputDecoration(
                    hintText:
                        '+1 (000) 000-0000', // You can customize this as needed
                    border: InputBorder.none, // Remove the input field border
                  ),
                  spaceBetweenSelectorAndTextField: 8,
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Email",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter email address',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Specify the outline border color
                      width: 1.0, // Specify the outline border width
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Website (Optional)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter website link',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Specify the outline border color
                      width: 1.0, // Specify the outline border width
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.currentPage < 2) {
                      // Increment the current page to move to the next page
                      widget.onPageChanged(widget.currentPage + 1);
                      // Use the PageController to animate the transition
                      widget.pageController.animateToPage(
                        widget.currentPage + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4e0ca2),
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DocumentDetailsSection extends StatefulWidget {
  final int currentPage;
  final PageController pageController;
  final Function(int) onPageChanged;

  const DocumentDetailsSection({
    super.key,
    required this.currentPage,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  State<DocumentDetailsSection> createState() => _DocumentDetailsSectionState();
}

class _DocumentDetailsSectionState extends State<DocumentDetailsSection> {
  String? selectedFileName;
  String? selectedBusinessLicense;

  Future<void> pickBusinessLicense() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx'
      ], // Add the allowed file extensions
    );

    if (result != null) {
      setState(() {
        selectedBusinessLicense = result.files.first.name;
      });
    }
  }

  Future<void> pickUtilityBill() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx'
      ], // Add the allowed file extensions
    );

    if (result != null) {
      setState(() {
        selectedFileName = result.files.first.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Upload Ownership Documents",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text("Upload documents for ownership verification process",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Business license or registration certificate",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedBusinessLicense != null
                          ? selectedBusinessLicense!
                          : "Chose file to upload",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        pickBusinessLicense();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 30),
                      ),
                      child: const Text(
                        "Select file",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Tax ID Number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter tax identification number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Specify the outline border color
                      width: 1.0, // Specify the outline border width
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Utility Bill or lease agreement",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedFileName != null
                          ? selectedFileName!
                          : "Chose file to upload",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        pickUtilityBill();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 30),
                      ),
                      child: const Text(
                        "Select file",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Provide a recent utility bill or lease agreement that matches the business address listed.",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // Your additional details form fields go here
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.currentPage < 2) {
                      // Increment the current page to move to the next page
                      widget.onPageChanged(widget.currentPage + 1);
                      // Use the PageController to animate the transition
                      widget.pageController.animateToPage(
                        widget.currentPage + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4e0ca2),
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactInformationSection extends StatefulWidget {
  const ContactInformationSection({super.key});

  @override
  State<ContactInformationSection> createState() =>
      _ContactInformationSectionState();
}

class _ContactInformationSectionState extends State<ContactInformationSection> {
  String selectedValue = 'Option 1';
  // Initial value
  List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Upload Ownership Documents",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Verify identity for secure ownership confirmation",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // Your contact information form fields go here
              const SizedBox(height: 20),
              const Text("First name",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter your first name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Specify the outline border color
                      width: 1.0, // Specify the outline border width
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text("Last name",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Specify the outline border color
                      width: 1.0, // Specify the outline border width
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Phone number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius:
                      BorderRadius.circular(8.0), // Add rounded corners
                ),
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DROPDOWN,
                  ),
                  onInputValidated: (bool value) {
                    // Validation logic can go here
                  },
                  inputDecoration: const InputDecoration(
                    hintText:
                        '+1 (000) 000-0000', // You can customize this as needed
                    border: InputBorder.none, // Remove the input field border
                  ),
                  spaceBetweenSelectorAndTextField: 8,
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text("Email",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Specify the outline border color
                      width: 1.0, // Specify the outline border width
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text("Identification Document",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
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
              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConfirmationPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4e0ca2),
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ClaimBusinessForm(),
  ));
}
