import 'package:_2geda/SideBar/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  void copyToClipboard(BuildContext context, String textToCopy) {
    FlutterClipboard.copy(textToCopy).then((_) {
      final snackBar = SnackBar(
        backgroundColor: const Color(0xff4e0ca2),
        content: Text('Copied to clipboard: $textToCopy'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((error) {
      final snackBar = SnackBar(
        content: Text('Failed to copy to clipboard: $error'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  static const url = 'https://2geda.net/tickets/ID1298';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/success.png'),
              const Text(
                textAlign: TextAlign.center,
                "Your event has been created",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                textAlign: TextAlign.center,
                "You can now share your unique ticket links to your attendees",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 224, 224, 224),),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(url),
                      IconButton(
                        onPressed: () {
                          copyToClipboard(context, url);
                        },
                        icon: const Icon(Icons.copy, size: 15,),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SideBarLayout(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  minimumSize: const Size(500, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Continue to Home",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              Image.asset('assets/banner2.png')
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SuccessPage(),
  ));
}
