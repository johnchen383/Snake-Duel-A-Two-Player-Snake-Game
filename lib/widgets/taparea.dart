import 'dart:math';

import 'package:flutter/material.dart';

class TapArea extends StatelessWidget {
  final double totalWidth;
  final Function whenTapped;
  final int tapId;
  final int player;

  TapArea(this.totalWidth, this.whenTapped, this.tapId, this.player);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        whenTapped(tapId, player);
      },
      child: Container(
        height: totalWidth / 2,
        width: totalWidth / 2,
        color: null,
        child: Center(
          child: GestureDetector(
            onTapDown: (_) {
              int id = (player == 1) ? tapId : ((tapId + 1) % 4) + 1;
              whenTapped(id, player);
            },
            child: Stack(children: [
              Icon(
                Icons.circle,
                size: 50,
                color: (player == 1) ? Colors.blue : Colors.red,
              ),
              Transform.rotate(
                angle: (pi / 2) * (tapId - 1) + (pi * 3 / 4),
                child: Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
