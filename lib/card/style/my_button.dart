import 'dart:math';
import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const MyButton({super.key, required this.onPressed, required this.child});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> 
  with SingleTickerProviderStateMixin {
    late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this
    ); 

    @override
    void dispose() {
      super.dispose();
      _controller.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return MouseRegion(
        onEnter: (event) {
            _controller.repeat();
        },
        onExit: (event) {
          _controller.stop(canceled: false);
        },
        child: RotationTransition(
          turns: _controller.drive(const _MySineTeen(0.05)),
          child: FilledButton(
            onPressed: widget.onPressed,
            child: widget.child,
            ),
          ),
      );
    }
  }

  class _MySineTeen extends Animatable<double> {
    final double maxExtent;

    const _MySineTeen(this.maxExtent);

    @override
    double transform(double t) {
      return sin(t * 2 * pi) * maxExtent;
    }
  }
