import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String day;
  final bool isSwitched;
  final void Function(bool) onChanged;

  const CustomSwitch({
    required this.day,
    required this.isSwitched,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(!widget.isSwitched);
      },
      child: Container(
        width: 80,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: widget.isSwitched ? const Color(0xff4e0ca2) : Colors.grey,
        ),
        child: Stack(
          children: [
            Positioned(
              left: widget.isSwitched ? 5 : 38,
              top: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.day,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              left: widget.isSwitched ? 50 : 0,
              top: 5,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
