import 'package:_2geda/pages/connect/presentation/widgets/comps/profile_btns.dart';
import 'package:_2geda/pages/connect/presentation/widgets/comps/profile_round_btn.dart';
import 'package:_2geda/utils/constant/app_color.dart';
import 'package:flutter/material.dart';

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({super.key});

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary1,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: kwhite),
              ),
              child: const Icon(
                Icons.more_horiz,
                color: kwhite,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(),
                      child: Image.asset('assets/profile_bck_img.png')),
                ),
                Positioned(
                  bottom: -40,
                  left: 50,
                  right: 50,
                  child: CircleAvatar(
                    radius: 50,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset(
                          'assets/avatar.png',
                          width: 50,
                          height: 50,
                        ),
                        Positioned(
                          bottom: -40,
                          right: -40,
                          child: Container(
                            width: 57,
                            height: 50,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            decoration: ShapeDecoration(
                              color:
                                  Colors.white.withOpacity(0.20000000298023224),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width: 30,
                                    height: 30,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: const Icon(
                                      Icons.image_outlined,
                                      color: kblckBtn,
                                    )),
                                const SizedBox(width: 7),
                                const Text(
                                  '2',
                                  style: TextStyle(
                                    color: Color(0xFF151313),
                                    fontSize: 16,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 55,
            ),
            Text(
              'Charlotte Caria Faith',
              style: TextStyle(
                color: Colors.black.withOpacity(0.800000011920929),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              'Product Designer',
              style: TextStyle(
                color: Colors.black.withOpacity(0.800000011920929),
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              'Lagos, Nigeria',
              style: TextStyle(
                color: Colors.black.withOpacity(0.800000011920929),
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileSqrBtns(
                  title: 'Stickers',
                  meter: '23k',
                ),
                const SizedBox(
                  width: 34,
                ),
                ProfileSqrBtns(
                  title: 'Sticking',
                  meter: '23k',
                )
              ],
            ),
            const SizedBox(
              height: 26,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileRoundBtns(
                  color: kPrimary,
                  content: 'Chat',
                ),
                const SizedBox(
                  width: 11,
                ),
                ProfileRoundBtns(
                  color: kPrimary1,
                  content: 'Stick',
                ),
              ],
            ),
            const SizedBox(height: 44),
            Image.asset('assets/banner_prof_screen.png'),
            const SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
    );
  }
}
