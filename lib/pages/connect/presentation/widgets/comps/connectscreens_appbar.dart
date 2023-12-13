import 'package:_2geda/pages/connect/presentation/widgets/comps/gender_btns.dart';
import 'package:_2geda/pages/connect/services/sort_connct_srv.dart';
import 'package:_2geda/utils/constant/app_color.dart';
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
  double _startValue = 20.0;
  double _endValue = 40.0;
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

                                print(genderCheck.value);
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            _startValue.toString(),
                            style: const TextStyle(
                              color: Color(0xFF0E0D0D),
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'to',
                            style: TextStyle(
                              color:
                                  Colors.black.withOpacity(0.4000000059604645),
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            _endValue.toString(),
                            style: const TextStyle(
                              color: Color(0xFF0E0D0D),
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  RangeSlider(
                    inactiveColor: kblckBtn,
                    activeColor: kblckBtn,
                    values: RangeValues(_startValue, _endValue),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    labels: RangeLabels('$_startValue', '$_endValue'),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _startValue = values.start;
                        _endValue = values.end;
                      });
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
                  GestureDetector(
                    onTap: sortConnectnotifie.value == true
                        ? null
                        : () async {
                            await sortConnectnotifie.sortConnctService(
                                startAge: 10,
                                endAge: 100,
                                location: 'location',
                                gender: 'gender',
                                verifiedAccount: true);
                            Navigator.pop(context);
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
                            ? const CircularProgressIndicator()
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
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
