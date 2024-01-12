import 'package:flutter/material.dart';

class Bounce extends StatefulWidget {
    Bounce({super.key});

    @override
    State<Bounce> createState() => _BounceState();
}

class _BounceState extends State<Bounce> with SingleTickerProviderStateMixin {
    late AnimationController _controller;
    late Animation topAnimation;

    void initState() {
        super.initState();

        _controller = AnimationController(
            duration: Duration(milliseconds: 500),
            vsync: this,
        );

        topAnimation = Tween<double>(begin: -10, end: 10).animate(_controller);

        _controller.addListener(() {
            setState(() {});
        });
        
        _controller.repeat();
    }

    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.only(top: 250),
            child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                    AnimatedPositioned(
                        duration: Duration(milliseconds: 500),
                        top: topAnimation.value,
                        child: Text(
                            "Hello Animation Bonce",
                            style: TextStyle(
                                fontSize: 32,
                            ),
                        ),
                    ),
                ],
            ),
        );
    }
}