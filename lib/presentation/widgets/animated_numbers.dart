import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final int targetCount;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.targetCount,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = IntTween(
      begin: 0,
      end: widget.targetCount,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          '${_animation.value}',
          style: TextStyle(
            color:
                Theme.of(context).colorScheme.primary.computeLuminance() > 0.5
                    ? Colors.grey[800]
                    : Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}
