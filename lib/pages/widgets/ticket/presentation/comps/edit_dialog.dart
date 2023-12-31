import 'package:_2geda/models/ticket.dart';
import 'package:flutter/material.dart';

class EditDialog extends StatelessWidget {
  final Event eventData;
  const EditDialog({Key? key, required this.eventData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement your edit dialog content here
    return AlertDialog(
      title: const Text('Edit Event'),
      content: const SizedBox(), // Your form fields for editing event details,
      actions: [
        TextButton(
          onPressed: () {
            // Handle Save button press
            // Update the event data and close the dialog
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () {
            // Close the dialog without saving changes
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
