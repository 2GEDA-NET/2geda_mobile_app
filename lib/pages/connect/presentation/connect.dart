import 'package:_2geda/pages/connect/presentation/widgets/comps/bizz_nearby.dart';
import 'package:_2geda/pages/connect/presentation/widgets/comps/hlf_btns.dart';
import 'package:_2geda/pages/connect/presentation/widgets/status_screen.dart';
import 'package:_2geda/utils/constant/app_color.dart';
import 'package:_2geda/pages/connect/presentation/widgets/comps/connectscreens_appbar.dart';
import 'package:_2geda/utils/globals/searc_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/story_model.dart';

class ConnectWithOtherUsers extends StatefulWidget {
  const ConnectWithOtherUsers({super.key});

  @override
  State<ConnectWithOtherUsers> createState() => _ConnectWithOtherUsersState();
}

class _ConnectWithOtherUsersState extends State<ConnectWithOtherUsers> {
  final TextEditingController searchController = TextEditingController();
  int screenTracker = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SearchField(
              hintTxt: 'Search users',
              controller: searchController,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
                width: 383,
                height: 43,
                child: Image.asset('assets/contBanner.png')),
          ),
          const SizedBox(height: 9),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: HalfButton(
                    onPressed: () {
                      setState(() {
                        screenTracker = 0;
                      });
                      if (kDebugMode) {
                        print(screenTracker);
                      }
                    },
                    titl: 'People nearby',
                    color: screenTracker == 0 ? kPrimary1 : kwhite,
                    txtColor: screenTracker == 0 ? kwhite : kblckBtn,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: HalfButton(
                    onPressed: () {
                      setState(() {
                        screenTracker = 1;
                      });
                      if (kDebugMode) {
                        print(screenTracker);
                      }
                    },
                    titl: 'Businesses nearby',
                    color: screenTracker == 1 ? kPrimary1 : kwhite,
                    txtColor: screenTracker == 1 ? Colors.white : kblckBtn,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          if (screenTracker == 0) ...[
            Flexible(
              child: StatusScreen(
                stories: stories,
              ),
            )
          ],
          if (screenTracker == 1) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: BusnessNearbyWidget(),
            )
          ],
          const SizedBox(
            height: 50,
          ),
        ]),
      ),
    );
  }
}
