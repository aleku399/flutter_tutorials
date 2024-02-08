import 'dart:async';
import 'package:flutter/material.dart';

import '../game_internals/board_state.dart';
import '../style/my_button.dart';
import '../style/pallet.dart';
import './board_widget.dart';

class PlayerSessionScreen extends StatelessWidget {
  const PlayerSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const BoardWidget(),
            const Text("Drag cards to the two areas above"),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(
                child: const Text('Back'),
                onPressed: () => print("Back"),
                ),
            ),
          ],
        )
      ],
    );
  }
}