import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<String> notifications = [
    'Notification 1',
    'Notification 2',
    'Notification 3',
    'Notification 4',
    'Notification 5',
  ];

  NotificationPage({super.key});

  void _removeNotification(int index) {
    // Remove the notification from the list
    notifications.removeAt(index);
  }

  // Define the _cleanUpPressed function somewhere in your code
  void _cleanUpPressed() {
    // Add your logic for the "Clean up" action here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xC9000000)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black, // Text color
            // You can also adjust other text styles such as fontSize, fontWeight, etc.
          ),
        ),
        centerTitle: true, // Center-align the title text
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0), // Add margin to the sides
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                "assets/banner.png",
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                height: 45,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Text("Recent searches",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    TextButton(
                      onPressed: () {
                        _cleanUpPressed();
                      },
                      child: const Text(
                        'Clean up',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true, // Added to make the ListView scrollable
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  // final timestamp = getTimestampForNotification(notification); // Replace with your actual timestamp logic
                  return ListTile(
                    title: Text(
                      notification, // Notification text as subtitle
                      style: const TextStyle(
                        fontSize: 14, // Adjust the font size
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: const Text(
                      '3hrs ago', // Replace with the actual timestamp
                      style: TextStyle(
                        fontSize: 12, // Adjust the font size
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    leading: Image.asset(
                      'assets/2geda-purple.png', // Replace with the path to your notification image
                      width: 24, // Adjust the width of the image
                      height: 24, // Adjust the height of the image
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
