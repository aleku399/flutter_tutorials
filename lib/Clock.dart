import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
    Clock({super.key});

    @override
    State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> with SingleTickerProviderStateMixin {
    late String _timeString;
    late AnimationController _controller;
    late Animation opacityAnimation;

    @override
    void initState() {
        super.initState();
        _timeString = _formatDateTime(DateTime.now());

        Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());

        _controller = AnimationController(
            duration: Duration(milliseconds: 300),
            vsync: this,
        );

        opacityAnimation = TweenSequence([
            TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.1), weight: 1.0),
            TweenSequenceItem(tween: Tween<double>(begin: 0.1, end: 1.0), weight: 1.0),
        ]).animate(_controller);
    }

    void _getTime() {
        final now = DateTime.now();
        final sanitizedTime = _formatDateTime(now);

        if (sanitizedTime != _timeString) {
            setState(() {
                _timeString = sanitizedTime;
                _controller.forward(from: 0.0);
            });
        }
    }

    String _formatDateTime(DateTime dateTime) {
        return DateFormat("HH:mm:ss").format(dateTime);
    }

    @override
    Widget build(BuildContext context) {
        return Center(
            child: AnimatedBuilder(
                animation: opacityAnimation,
                builder: (BuildContext context, child) {
                    return AnimatedOpacity(
                        opacity: opacityAnimation.value,
                        duration: Duration(milliseconds: 300),
                        child: Text(
                            _timeString,
                            style: TextStyle(
                                fontSize: 72.0,
                                color: Colors.lime[800],
                            ),
                        ),
                    );
                },
            ),
        );
    }
} 