import 'package:flutter/material.dart';

class AnimatedCircularProgress extends StatefulWidget {
  final double progress;
  final double strokeWidth;
  final Color color;

  const AnimatedCircularProgress({
    super.key,
    required this.progress,
    this.strokeWidth = 2.0,
    this.color = Colors.blueAccent,
  });

  @override
  State<AnimatedCircularProgress> createState() => _AnimatedCircularProgressState();
}

class _AnimatedCircularProgressState extends State<AnimatedCircularProgress> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousProgress = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0.0, end: widget.progress).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(AnimatedCircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.progress != oldWidget.progress) {
      _previousProgress = _animation.value;
      _controller.reset();
      _animation = Tween<double>(begin: _previousProgress, end: widget.progress).animate(_controller);
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: _animation.value,
      strokeWidth: widget.strokeWidth,
      color: widget.color,
    );
  }
}
