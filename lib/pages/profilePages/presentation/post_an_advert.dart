
import 'package:_2geda/pages/profilePages/presentation/advert_preview.dart';
import 'package:flutter/material.dart';

class PostAnAdvert extends StatefulWidget {
  const PostAnAdvert({super.key});

  @override
  State<PostAnAdvert> createState() => _PostAnAdvertState();
}

class _PostAnAdvertState extends State<PostAnAdvert> {
  String selectedValue = ''; // Initialize with a default value
  List<String> dropdownItems = ['Christian', 'Muslim', 'Indigenous', 'Others'];
  final TextStyle activeTextStyle = const TextStyle(
      color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400);
  final TextStyle inactiveTextStyle = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400);
  final Color activeBackgroundColor =
      const Color(0xff4e0ca2); // Change to your desired color
  final Color inactiveBackgroundColor = const Color(0x19000000);
  int? selectedDuration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Post an Advert',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color(0xFF4E0CA2),
                    borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.broadcast_on_home,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      child: Text(
                          "Reach out to World Audience in Large Numbers\nwhile you Pay Less.",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Advert information",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Advert title',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Specify the outline border color
                      width: 1.0, // Specify the outline border width
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: null,
                items: dropdownItems.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: SizedBox(
                      height: 20, // Adjust the height of the DropdownMenuItem
                      child: Center(
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Select Advert Category',
                  labelStyle: TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 30, // Adjust the icon size
                ),
              ),
              const SizedBox(height: 20),
              const Text("Duration",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRadioContainer(1, '24 hours'),
                  _buildRadioContainer(2, '48 hours'),
                  _buildRadioContainer(3, '72 hours'),
                  _buildRadioContainer(4, '1 week'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRadioContainer(5, '2 weeks'),
                  _buildRadioContainer(6, '1 month'),
                  _buildRadioContainer(7, '3 months'),
                  _buildRadioContainer(8, '1 year'),
                ],
              ),
              const SizedBox(height: 10),
              const Text("Set Custom Duration",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 10),

              // Row(
              //   children: [
              //     DateTimeFormField(
              //         decoration: const InputDecoration(
              //           hintStyle: TextStyle(
              //               color: Colors.black45,
              //               fontSize: 12), // Change the font size here
              //           errorStyle: TextStyle(
              //               color: Colors.redAccent,
              //               fontSize: 12), // Change the font size here
              //           border: OutlineInputBorder(),
              //           suffixIcon: Icon(Icons.event_note),
              //           labelText: 'Start',
              //           labelStyle: TextStyle(fontSize: 12),
              //         ),
              //         mode: DateTimeFieldPickerMode.date,
              //         autovalidateMode: AutovalidateMode.always,
              //         firstDate: DateTime(1900), // Set your minimum allowable year
              //         lastDate: DateTime.now().subtract(
              //             const Duration(days: 1)), // Set lastDate to yesterday
              //         initialDate: DateTime.now().subtract(const Duration(
              //             days: 1)), // Set initialDate to yesterday or earlier
              //         onDateSelected: (DateTime value) {
              //           print(value);
              //         },
              //       ),

              //       Text("to"),
              //       DateTimeFormField(
              //     decoration: const InputDecoration(
              //       hintStyle: TextStyle(
              //           color: Colors.black45,
              //           fontSize: 12), // Change the font size here
              //       errorStyle: TextStyle(
              //           color: Colors.redAccent,
              //           fontSize: 12), // Change the font size here
              //       border: OutlineInputBorder(),
              //       suffixIcon: Icon(Icons.event_note),
              //       labelText: 'Ends',
              //       labelStyle: TextStyle(fontSize: 12),
              //     ),
              //     mode: DateTimeFieldPickerMode.date,
              //     autovalidateMode: AutovalidateMode.always,
              //     firstDate: DateTime(1900), // Set your minimum allowable year
              //     lastDate: DateTime.now().subtract(
              //         const Duration(days: 1)), // Set lastDate to yesterday
              //     initialDate: DateTime.now().subtract(const Duration(
              //         days: 1)), // Set initialDate to yesterday or earlier
              //     onDateSelected: (DateTime value) {
              //       print(value);
              //     },
              //   ),

              //   ],
              // ),

              const Text("Upload advert image",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Row(
                    children: [
                      Icon(Icons.camera_alt_outlined, color: Colors.white),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Select file",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const TextField(
                // controller: postTextController,
                decoration: InputDecoration(
                  hintText: 'Add a note(optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdvertPreview(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4e0ca2),
                    minimumSize: const Size(300, 60),
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(1),
                    // ),
                  ),
                  child: const Text(
                    "Preview cost",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioContainer(int value, String label) {
    final isSelected = selectedDuration == value;
    return InkWell(
      onTap: () {
        setState(() {
          selectedDuration = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? activeBackgroundColor : inactiveBackgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: isSelected ? activeTextStyle : inactiveTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
