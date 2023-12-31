import 'package:_2geda/pages/stereoPages/uploadMusic/album/add_existing.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AlbumEpUpload extends StatefulWidget {
  const AlbumEpUpload({super.key});

  @override
  State<AlbumEpUpload> createState() => _AlbumEpUploadState();
}

class _AlbumEpUploadState extends State<AlbumEpUpload> {
  String selectedValue = ''; // Initialize with a default value
  List<String> dropdownItems = ['Christian', 'Muslim', 'Indigenous', 'Others'];
  
  @override
  Widget build(BuildContext context) {
    Future<void> pickCoverImgFile() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false, // Allow only one file to be selected
      );

      if (result != null) {
        final file = result.files.first;
        final fileName = file.name;
        // Handle the selected file (e.g., upload it or display its name)
        print("Selected file: $fileName");
      }
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            'Album Upload',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/2geda-purple.png'),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Your song has been uploaded!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text("Follow these steps to complete your upload",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      color: const Color.fromARGB(255, 235, 234, 234),
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      InkWell(
                        onTap:
                            pickCoverImgFile, // Call the file picker function
                        child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(255, 138, 21, 1.0)),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Add cover image",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Artist name',
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
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Album title',
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
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Producers',
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
                    labelText: 'Genre',
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


              const SizedBox(
                height: 40,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const AddExistingSong(), // Replace with the actual screen
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xff4e0ca2), // Change background color
                    minimumSize:
                        const Size(250, 60), // Increase width and height
                  ),
                  child: const Text(
                    "Upload",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Image.asset("assets/banner2.png")
            ],
          ),
        ));
  }
}
