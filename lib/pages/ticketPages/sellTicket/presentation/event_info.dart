import 'package:_2geda/pages/ticketPages/sellTicket/presentation/event_loc_map.dart';
import 'package:_2geda/pages/ticketPages/sellTicket/presentation/state/location_loading_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Import the geocoding package

class EventInfoStep extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController platformController;
  final TextEditingController websiteUrlController;
  final Function(XFile?) onImageSelected; // Callback function
  final TextEditingController imageController;
  final TextEditingController locationController;
  final int currentStep;
  final LatLng selectedLocation;

  EventInfoStep({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.platformController,
    required this.websiteUrlController,
    required this.onImageSelected, // Add this line
    required this.imageController,
    required this.currentStep,
    required this.selectedLocation,
    required this.locationController,
  });

  @override
  State<EventInfoStep> createState() => _EventInfoStepState();
}

class _EventInfoStepState extends State<EventInfoStep> {
  LatLng? selectedLocation;

  XFile? _image;

  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = image;
        widget.onImageSelected(
            _image); // Notify the parent about the selected image
      });
    }
  }

  Future<String> _getAddressFromLocation(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark firstPlacemark = placemarks.first;
        String address = '${firstPlacemark.street}, ${firstPlacemark.locality}';
        return address;
      } else {
        return "Address not found";
      }
    } catch (e) {
      print("Error retrieving address: $e");
      return "Error retrieving address";
    }
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
            controller: widget.titleController,
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
            controller: widget.descriptionController,
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
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: widget.platformController,
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
            onPressed: () {
              _showLocationPicker(context);
            },
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
          // Display selected location if available
          if (selectedLocation != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FutureBuilder<String>(
                future: _getAddressFromLocation(selectedLocation!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // If the Future is still running, show a loading indicator
                    return LocationLoadingState();
                  } else if (snapshot.hasError) {
                    // If there is an error, display an error message
                    return Text("Error retrieving address: ${snapshot.error}");
                  } else {
                    // If the Future is completed, display the address
                    return Text(
                      'Selected Location: ${snapshot.data}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }
                },
              ),
            ),

          TextFormField(
            controller: widget.websiteUrlController,
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
        border: Border.all(width: 1),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _getImage,
            icon: const Icon(
              Icons.upload_file,
            ),
          ),
          const Text(
            "Upload event image",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (_image?.name != null)
            Column(
              children: [
                const SizedBox(height: 8),
                Text(
                  "Image: ${_image!.name}",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          const Text(
            "Upload a compelling image. We recommend using at least a 2160x1080px (2:1 ratio) image that's no larger than 10MB",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the location picker
  Future<void> _showLocationPicker(BuildContext context) async {
    LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerScreen(),
      ),
    );

    // Update the selected location
    if (pickedLocation != null) {
      setState(() {
        selectedLocation = pickedLocation;
      });

      // Convert selected location to address
      String address = await _getAddressFromLocation(pickedLocation);
      print("Selected Location: $address");

      // Send address through a controller
      widget.locationController.text = address;
    }
  }
}
