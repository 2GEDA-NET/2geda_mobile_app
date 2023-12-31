import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class ReferralPage extends StatefulWidget {
  const ReferralPage({Key? key}) : super(key: key);

  @override
  State<ReferralPage> createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> {
  bool isUsingPhoneNumber = false; // Track if using phone number

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

  static const url = '2geda.net/faithawokunle';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Rewards',
            ),
            centerTitle: true,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/2geda-purple.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ]),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/coin_amico.png"),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Earn real prizes for inviting \n your friends on 2geda",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4e0ca2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Start earning",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white))),
                const SizedBox(
                  height: 10,
                ),
                const Text("Or",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: isUsingPhoneNumber ? 'Phone Number' : 'Email',
                    hintText: isUsingPhoneNumber
                        ? 'Enter your phone number'
                        : 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    suffix: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4e0ca2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Send",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical:
                          6.0, // Adjust this value to reduce vertical padding
                      horizontal: 8.0,
                    ),
                  ),
                  keyboardType: isUsingPhoneNumber
                      ? TextInputType.phone
                      : TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your ${isUsingPhoneNumber ? 'phone number' : 'email'}';
                    }
                    return null;
                  },
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isUsingPhoneNumber = !isUsingPhoneNumber;
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xff4e0ca2),
                  ),
                  child: Text(
                    isUsingPhoneNumber
                        ? "Use Email instead"
                        : "Use Phone number instead",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAE3F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                          icon: const Icon(
                            Icons.copy,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD0D5DD),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Text("How to earn",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          )),
                      howToEarnCard(
                          "1", "Share your referral link with your friends"),
                      howToEarnCard("2",
                          "Your friend clicks and registers through your referral link"),
                      howToEarnCard("3", "You received your reward"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget howToEarnCard(number, text) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFF8A15),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(number,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )),
        ),
        title: Text(text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            )),
      ),
    );
  }
}
