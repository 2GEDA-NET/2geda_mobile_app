import 'package:flutter/material.dart';

class NumberCountingAnimation extends StatefulWidget {
  final int startValue;
  final int endValue;
  final Duration duration;

  const NumberCountingAnimation({
    super.key,
    required this.startValue,
    required this.endValue,
    required this.duration,
  });

  @override
  _NumberCountingAnimationState createState() =>
      _NumberCountingAnimationState();
}

class _NumberCountingAnimationState extends State<NumberCountingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = IntTween(
      begin: widget.startValue,
      end: widget.endValue,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Text(
          '${_animation.value}',
          style: const TextStyle(fontSize: 24),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
