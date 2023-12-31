import 'package:_2geda/pages/connect/presentation/widgets/comps/gender_btns.dart';
import 'package:_2geda/pages/connect/services/sort_connct_srv.dart';
import 'package:_2geda/utils/constant/app_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MAppBar({super.key});

  @override
  State<MAppBar> createState() => _MAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MAppBarState extends State<MAppBar> {
  ValueNotifier<RangeValues> rangeValues = ValueNotifier<RangeValues>(
    const RangeValues(20.0, 40.0),
  );

  ValueNotifier<bool> isChecked = ValueNotifier(false);
  // bool isChecked = false;
  ValueNotifier<String> genderCheck = ValueNotifier('Male');
  final responseNotifier = ValueNotifier<String>('');
  final SortConnctServiceNotifier sortConnectnotifie =
      SortConnctServiceNotifier();

  // String genderCheck = 'Male';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Image.asset(
          'assets/2geda-purple.png',
          width: 40,
          height: 40,
        ),
      ),
      title: const Text(
        'Connect with other users',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: GestureDetector(
            onTap: () {
              _showBottomSheet(context);
            },
            child: SvgPicture.asset(
              'assets/filtering.svg',
              width: 34,
              height: 34,
            ),
          ),
        )
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 500,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Row(
                    children: [
                      Text(
                        'Sort by',
                        style: TextStyle(
                          color: Color(0xFF0E0D0D),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Reset',
                        style: TextStyle(
                          color: Color(0xFF0E0D0D),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Gender',
                    style: TextStyle(
                      color: Color(0xFF0E0D0D),
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ValueListenableBuilder(
                      valueListenable: genderCheck,
                      builder: (context, value, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: GenderBtns(
                              txtColor: genderCheck.value == 'Female' ||
                                      genderCheck.value == 'Others'
                                  ? kblckBtn
                                  : kwhite,
                              color: genderCheck.value == 'Female' ||
                                      genderCheck.value == 'Others'
                                  ? const Color(0xFFD9D9D9)
                                  : const Color(0xFF4E0CA2),
                              onPressed: () {
                                genderCheck.value = 'Male';

                                if (kDebugMode) {
                                  print(genderCheck.value);
                                }
                              },
                              titl: 'Male',
                            )),
                            const SizedBox(
                              width: 11,
                            ),
                            Flexible(
                                child: GenderBtns(
                              txtColor: genderCheck.value == 'Male' ||
                                      genderCheck.value == 'Others'
                                  ? kblckBtn
                                  : kwhite,
                              color: genderCheck.value == 'Male' ||
                                      genderCheck.value == 'Others'
                                  ? const Color(0xFFD9D9D9)
                                  : const Color(0xFF4E0CA2),
                              onPressed: () {
                                genderCheck.value = 'Female';

                                print(genderCheck.value);
                              },
                              titl: 'Female',
                            )),
                            const SizedBox(
                              width: 11,
                            ),
                            Flexible(
                                child: GenderBtns(
                              txtColor: genderCheck.value == 'Female' ||
                                      genderCheck.value == 'Male'
                                  ? kblckBtn
                                  : kwhite,
                              color: genderCheck.value == 'Female' ||
                                      genderCheck.value == 'Male'
                                  ? const Color(0xFFD9D9D9)
                                  : const Color(0xFF4E0CA2),
                              onPressed: () {
                                genderCheck.value = 'Others';

                                print(genderCheck.value);
                              },
                              titl: 'Others',
                            )),
                          ],
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Age range',
                        style: TextStyle(
                          color: Color(0xFF0E0D0D),
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      ValueListenableBuilder(
                          valueListenable: rangeValues,
                          builder: (context, values, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  rangeValues.value.start.toStringAsFixed(0),
                                  style: const TextStyle(
                                    color: Color(0xFF0E0D0D),
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'to',
                                  style: TextStyle(
                                    color: Colors.black
                                        .withOpacity(0.4000000059604645),
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  rangeValues.value.end.toStringAsFixed(0),
                                  style: const TextStyle(
                                    color: Color(0xFF0E0D0D),
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  ValueListenableBuilder(
                    valueListenable: rangeValues,
                    builder: (context, values, child) {
                      return RangeSlider(
                        values: values,
                        labels: RangeLabels(
                            rangeValues.value.start.toStringAsFixed(0),
                            rangeValues.value.end.toStringAsFixed(0)),
                        min: 0.0,
                        max: 100.0,
                        onChanged: (RangeValues newValues) {
                          rangeValues.value = newValues;
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Text(
                        'Location',
                        style: TextStyle(
                          color: Color(0xFF0E0D0D),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Text(
                        'Verified Account',
                        style: TextStyle(
                          color: Color(0xFF0E0D0D),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      ValueListenableBuilder(
                          valueListenable: isChecked,
                          builder: (context, value, child) {
                            return Checkbox(
                              value: isChecked.value,
                              onChanged: (bool? val) {
                                isChecked.value = val ?? false;

                                print(isChecked.value.toString());
                              },
                            );
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 31,
                  ),
                  ValueListenableBuilder(
                      valueListenable: sortConnectnotifie,
                      builder: (context, value, chil) {
                        return GestureDetector(
                          onTap: sortConnectnotifie.value == true
                              ? null
                              : () async {
                                  await sortConnectnotifie.sortConnctService(
                                      startAge: rangeValues.value.start.toInt(),
                                      endAge: rangeValues.value.end.toInt(),
                                      location: 'location',
                                      gender: genderCheck.value,
                                      verifiedAccount: isChecked.value);
                                  Navigator.pop(context, true);
                                },
                          child: Container(
                            height: 45,
                            decoration: ShapeDecoration(
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: sortConnectnotifie.value == true
                                  ? const Center(
                                      child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: kwhite,
                                          )))
                                  : const Text(
                                      'Apply',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
