import 'package:_2geda/pages/authentication/profile/business_profile_form.dart';
import 'package:flutter/material.dart';

class ManageStoreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/nothing_here.png'),
        const Text(
          "No business yet!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BusinessProfileFormPage(),
                ),
              );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                const Color(0xffff8a15), // Set the background color to red
            minimumSize: const Size(150, 40), // Set the desired size
          ),
          child: const Text("+ Create a Business acccount now",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              )),
        ),
      ],
    );
  }
}
