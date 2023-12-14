import 'package:flutter/material.dart';

class AdditionalInfoStep extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController feeSettingCategoryController;
  final TextEditingController showRemainingTicketController;
  final TextEditingController isPublicController;
  final TextEditingController isPrivateController;

  const AdditionalInfoStep({
    super.key,
    required this.formKey,
    required this.feeSettingCategoryController,
    required this.showRemainingTicketController,
    required this.isPublicController,
    required this.isPrivateController,
  });

  @override
  State<AdditionalInfoStep> createState() => _AdditionalInfoStepState();
}

class _AdditionalInfoStepState extends State<AdditionalInfoStep> {
  bool _showRemainingTicket = false; // Define the 'value' variable
  bool _isPublic = true; // Define the 'value' variable
  bool _isPrivate = false; // Define the 'value' variable
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
                value: _showRemainingTicket,
                onChanged: (newValue) {
                  setState(() {
                    _showRemainingTicket = newValue;
                    widget.showRemainingTicketController.text =
                        newValue.toString();
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
                  setState(() {
                    _isPublic = newValue;
                    widget.isPublicController.text = newValue.toString();
                    if (newValue) {
                      _isPrivate = false;
                      widget.isPrivateController.text = 'false';
                    }
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
                  setState(() {
                    _isPrivate = newValue;
                    widget.isPrivateController.text = newValue.toString();
                    if (newValue) {
                      _isPublic = false;
                      widget.isPublicController.text = 'false';
                    }
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
                        widget.feeSettingCategoryController.text = newValue!;
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
      ),
    );
  }
}
