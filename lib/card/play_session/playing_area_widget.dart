import 'dart:math';
import 'package:flutter/material.dart';

import '../game_internals/playing_area.dart';
import '../game_internals/playing_card.dart';
import '../style/pallet.dart';
import './playing_card_widget.dart';

class PlayerAreaWidget extends StatefulWidget {
  final PlayingArea area;

  const PlayerAreaWidget(this.area, {super.key});

  @override
  State<PlayerAreaWidget> createState () => _PlayingAreaWidgetState();
} 

class _PlayingAreaWidgetState extends State<PlayerAreaWidget> {
  bool isHighLighted = false;

  @override
  Widget build(BuildContext context) {
    final palette = Palette();

    return LimitedBox(
      maxHeight: 200,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: DragTarget<PlayingCardDragData>(
          builder: (context, candidateData, rejectedData) => SizedBox(
            height: 100,
            child: Material(
              color: isHighLighted ? palette.accept : palette.trueWhite,
              shape: const CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: palette.redPen,
                onTap: _onAreaTap,
                child: StreamBuilder(
                  stream: widget.area.allChanges,
                  builder: (context, child) => _CardStack(widget.area.cards),
                ), 
              ),
            ),
          ),
          onWillAcceptWithDetails: _onDragWillAccept,
          onLeave: _onDragLeave,
          onAcceptWithDetails: _onDragAccept,
        ),
      ),
    );
  }

  void _onAreaTap() {
    widget.area.removeFirstCard();
  }

  void _onDragAccept(DragTargetDetails<PlayingCardDragData> details) {
    widget.area.acceptCard(details.data.card);
    details.data.holder.removeCard(details.data.card);
    setState(() {
      isHighLighted = false;
    });
  }

  void _onDragLeave(PlayingCardDragData? data) {
    setState(() {
      isHighLighted = false;
    });
  }

  bool _onDragWillAccept(DragTargetDetails<PlayingCardDragData> details) {
    setState(() {
      isHighLighted = true;
    });
    return true;
  }

}

class _CardStack extends StatelessWidget {
  static const int _maxCards = 6;

  static const _leftOffset = 10.0;

  static const _topOffset = 5.0;

  static const double _maxWidth = 
    _maxCards * _leftOffset + PlayingCardWidget.width;

  static const double _maxHeight = 
    _maxCards * _topOffset + PlayingCardWidget.height;

  final List<PlayingCard> cards;

  const _CardStack(this.cards);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: _maxWidth,
        height: _maxHeight,
        child: Stack(
          children: [
            for (var i = max(0, cards.length - _maxCards);  i < cards.length; i++)
            Positioned(
              top: i * _topOffset,
              left: i * _leftOffset,
              child: PlayingCardWidget(cards[i]),
            ),
          ],
        ),
      ),
    );
  }
}