import 'dart:math';
import 'package:flutter/material.dart';


const _duration = Duration(seconds: 2);

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

class _AnimationContainerState extends State<AnimationContainer> with SingleTickerProviderStateMixin {
    late AnimationController controller;
    late Animation marginAnimation;
    late Animation radiusAnimation;
    late Animation colorAnimation;
  
    @override
    void initState() {
        super.initState();
        controller = AnimationController(
            duration: _duration,
            vsync: this,
        );
        marginAnimation = Tween<double>(begin: randomMargin(), end: randomMargin() ).animate(controller);
        radiusAnimation = Tween<double>(begin:  randomBorderRadius(), end:  randomBorderRadius() ).animate(controller);
        colorAnimation = ColorTween(begin: randomColor(), end: randomColor()).animate(controller);

        controller.addListener(() {
            setState(() {});
        });
 
        controller.repeat();
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
                        child: Container(
                            margin: EdgeInsets.all(marginAnimation.value),
                            decoration: BoxDecoration(
                                color: colorAnimation.value,
                                borderRadius: BorderRadius.circular(radiusAnimation.value),

                            ),
                        ),
                    ),
                ],
            ),
        );
    }

    @override
    void dispose() {
        controller.dispose();
        super.dispose();
    }

}