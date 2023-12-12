import 'package:_2geda/utils/constant/app_color.dart';
import 'package:flutter/material.dart';

class AnimatedBar extends StatelessWidget {
  final AnimationController? animController;
  final int? position;
  final int? currentIndex;

  const AnimatedBar({
    Key? key,
    this.animController,
    this.position,
    this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5, vertical: 1),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position! < currentIndex!
                      ? Colors.grey.withOpacity(0.5)
                      : Colors.grey.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                        animation: animController!,
                        builder: (context, child) {
                          return _buildContainer(
                            constraints.maxWidth * animController!.value,
                            kPrimary1,
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
