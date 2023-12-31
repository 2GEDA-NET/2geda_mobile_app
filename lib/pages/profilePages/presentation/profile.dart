import 'dart:io';

import 'package:_2geda/pages/profilePages/data/uer_profile_res.dart';
import 'package:_2geda/pages/profilePages/presentation/change_password.dart';
import 'package:_2geda/pages/profilePages/presentation/device_reg.dart';
import 'package:_2geda/pages/profilePages/presentation/manage_advert.dart';
import 'package:_2geda/pages/profilePages/presentation/reward/earn_reward.dart';
import 'package:_2geda/pages/profilePages/presentation/saved_post.dart';
import 'package:_2geda/pages/profilePages/presentation/verification.dart';
import 'package:_2geda/pages/profilePages/service/fetch_profile_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _coverImage;
  XFile? _profileImage;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  Future<void> _pickImage(ImageSource source, bool isCoverImage) async {
    try {
      final pickedImage = await _picker.pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          if (isCoverImage) {
            _coverImage = pickedImage;
          } else {
            _profileImage = pickedImage;
          }
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/2geda-purple.png',
            width: 40,
            height: 40,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 80,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon:
                const Icon(Icons.menu), // Change the icon to your desired icon
            onPressed: () {
              scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Container(
          height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/2geda-purple.png',
                    width: 40,
                    height: 40,
                  ),
                  IconButton(
                    icon: const Icon(
                        Icons.close), // Change the icon to your desired icon
                    onPressed: () {
                      scaffoldKey.currentState?.closeEndDrawer();
                    },
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChangePassword(), // Replace with the actual screen
                    ),
                  );
                },
                child: const Text(
                  "Account Settings",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const SavedPosts(), // Replace with the actual screen
                    ),
                  );
                },
                child: const Text(
                  "Saved Posts",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const Verification(), // Replace with the actual screen
                    ),
                  );
                },
                child: const Text(
                  "Request Verification",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ManageAdvert(), // Replace with the actual screen
                    ),
                  );
                },
                child: const Text(
                  "Manage Adverts",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const EarnReward(), // Replace with the actual screen
                    ),
                  );
                },
                child: const Text(
                  "Earn rewards",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const DevicesReg(), // Replace with the actual screen
                    ),
                  );
                },
                child: const Text(
                  "Phone IMEI/ Gadget serial no",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              const Text("Sign in another account",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                height: 40,
              ),
              const CircleAvatar(
                radius: 20,
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Logout",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.red)),
                    ],
                  ))
            ],
          ),
        ),
      ),
      body: FutureBuilder<UserProfileModel>(
          future: userProfileSrv(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            return Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    _buildImageFrame(
                        isCoverImage: true,
                        text: "Add Cover Image",
                        image: _coverImage,
                        img: snapshot.data!.coverImage ?? ''),
                    Positioned(
                      top: 100,
                      child: _buildProfileImageFrame(
                          isProfileImage: true,
                          image: _profileImage,
                          img: snapshot.data!.media[0].profileImage ?? ''),
                    ),
                  ],
                ),
                Center(
                  child: Column(
                    children: [
                      Text(snapshot.data!.username ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      // const Text("Product Designer",
                      //     style: TextStyle(
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w300,
                      //     )),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          '${snapshot.data!.address!.currentCity ?? ''}, ${snapshot.data!.address!.country ?? ''}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: 125,
                            decoration: BoxDecoration(
                                color: const Color(0xFF4E0CA2),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Column(
                              children: [
                                Text("Stickers",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("18m",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: 125,
                            decoration: BoxDecoration(
                                color: const Color(0xFF4E0CA2),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Column(
                              children: [
                                Text("Sticking",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("18m",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/banner2.png"),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  // color: Colors.white,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: buildTabButtons(),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    children: const [
                      Center(child: Text('All Tab Content')),
                      Center(child: Text('People Tab Content')),
                      Center(child: Text('Media Tab Content')),
                      Center(child: Text('Business Tab Content')),
                      Center(child: Text('Places Tab Content')),
                      Center(child: Text('Jobs Tab Content')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/banner2.png"),
                )
              ],
            );
          }),
    );
  }

  List<Widget> buildTabButtons() {
    final tabLabels = [
      'All Post',
      'Images',
      'Video',
      'Voice note',
      'Location',
      'Music',
      'Files'
    ];

    return tabLabels.asMap().entries.map((entry) {
      final index = entry.key;
      final label = entry.value;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                _currentIndex == index ? const Color(0xff4f0da3) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the radius as needed
            ),
          ),
          onPressed: () {
            // Update the PageView when a tab button is pressed
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: Text(
            label,
            style: TextStyle(
              color: _currentIndex == index ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildImageFrame({
    required bool isCoverImage,
    required String text,
    String? img,
    XFile? image,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (image != null)
            Image.file(
              File(image.path),
              width: double.infinity,
              height: 140,
              fit: BoxFit.cover,
            ),
          if (image == null)
            Positioned(
              top:
                  0, // Adjust the top value to control the purple content's position
              child: img == ''
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 162, 12, 12),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _pickImage(ImageSource.gallery, isCoverImage);
                            },
                            icon: const Icon(
                              Icons.image,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            text,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: img!,
                      fit: BoxFit.fill,
                    ),
            ),
          Positioned(
            // top: 20,
            right: 0,
            bottom: 23,
            child: GestureDetector(
              onTap: () {
                _pickImage(ImageSource.gallery, isCoverImage);
              },
              child: Container(
                width: 30, // Adjust the width
                height: 30, // Adjust the height
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                child: const Center(
                  child: Icon(
                    Icons.edit,
                    size: 15,
                    color: Colors.white, // Optional: Change icon color
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImageFrame({
    required bool isProfileImage,
    String? img,
    XFile? image,
  }) {
    return Container(
      width: 100, // Set the width to match the image size
      height: 100, // Set the height to match the image size
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.black),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (image != null)
            ClipOval(
              child: Image.file(
                File(image.path),
                width: 100, // Set the width to match the container size
                height: 100, // Set the height to match the container size
                fit: BoxFit.cover,
              ),
            ),
          if (image == null)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                img == ''
                    ? Image.asset('assets/avatar.png')
                    : CachedNetworkImage(
                        imageUrl: img!,
                        fit: BoxFit.fill,
                      )
              ],
            ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                _pickImage(ImageSource.gallery, false);
              },
              child: Container(
                width: 30, // Adjust the width
                height: 30, // Adjust the height
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                child: const Center(
                  child: Icon(
                    Icons.edit,
                    size: 15,
                    color: Colors.white, // Optional: Change icon color
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
