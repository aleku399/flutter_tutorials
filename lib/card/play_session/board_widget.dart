import 'package:flutter/material.dart';
import 'package:flutter_tutorials/card/play_session/player_hand_widget.dart';
import '../game_internals/board_state.dart';
import './playing_area_widget.dart';

class BoardWidget extends StatefulWidget {
  const BoardWidget({super.key});

  @override
  State<BoardWidget> createState () => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  @override
  Widget build(BuildContext context) {
    final boardState = BoardState();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: [
              PlayerAreaWidget(boardState.areaOne),
              PlayerAreaWidget(boardState.areaTwo),
            ],
          ),
        ),
        const PlayerHandWidget(),
      ],

    );
  } 
}