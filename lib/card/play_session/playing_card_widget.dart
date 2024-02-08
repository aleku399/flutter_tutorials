import 'package:flutter/material.dart';

import '../game_internals/card_suit.dart';
import '../game_internals/player.dart';
import '../game_internals/playing_card.dart';
import '../style/pallet.dart';

class PlayingCardWidget extends StatelessWidget {
  static const double width = 57.1;
  static const double height = 89.1;
  final PlayingCard card;
  final Player? player;

  const PlayingCardWidget(this.card, {super.key, this.player});

  @override
  Widget build(BuildContext context) {
    final palette = Palette();
    final textColor = 
      card.suit.color == CardSuitColor.red ? palette.redPen : palette.ink;

    final cardWidget = DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyMedium!.apply(color: textColor),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: palette.trueWhite,
          border: Border.all(color: palette.ink),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            '${card.suit.asCharacter}\n${card.value}',
            textAlign: TextAlign.center,
            ),
        ),
      ),
    );

    if (player == null) return cardWidget;

    return Draggable(
      feedback: Transform.rotate(
        angle: 0.1,
        child: cardWidget,
      ),
      data: PlayingCardDragData(card, player!),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: cardWidget,
      ),
      child: cardWidget, 
    );
  }

}

@immutable
class PlayingCardDragData {
  final PlayingCard card;

  final Player holder;

  const PlayingCardDragData(this.card, this.holder);
}