import 'dart:math';
import 'package:flutter/material.dart';


const _duration = Duration(milliseconds: 400);

double randomBorderRadius() {
    return Random().nextDouble() * 64;
}

double randomMargin() {
    return Random().nextDouble() * 64;
}

Color randomColor() {
    return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}

class AnimationContainer extends StatefulWidget {
    AnimationContainer({super.key});

    @override
    State<AnimationContainer> createState() => _AnimationContainerState();
}

class _AnimationContainerState extends State<AnimationContainer> {
    late double _margin;
    late double _radius;
    late Color _color;

    @override
    void initState() {
        super.initState();
        _color = randomColor();
        _margin = randomMargin();
        _radius = randomBorderRadius();
    }

    void _animateContainer() {
        setState(() {
            _color = randomColor();
            _radius = randomBorderRadius();
            _margin = randomMargin();
        });
    }


    @override
    Widget build(BuildContext context) {
        return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    SizedBox(
                        width: 160,
                        height: 160,
                        child: AnimatedContainer(
                            margin: EdgeInsets.all(_margin),
                            decoration: BoxDecoration(
                                color: _color,
                                borderRadius: BorderRadius.circular(_radius),

                            ),
                            duration: _duration,
                            curve: Curves.easeInOutBack,
                        ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                        child: Text(
                            "Animate Me"
                        ),
                        onPressed:  _animateContainer,
                    ),
                ],
            ),
        );
    }
}