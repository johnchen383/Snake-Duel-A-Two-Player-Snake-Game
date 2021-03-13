import 'package:flutter/material.dart';
import 'dart:math';

class ControlArea extends StatelessWidget {
  final Function updateDirection;
  final int playerControlled;

  ControlArea(this.updateDirection, this.playerControlled);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          updateDirection(2, playerControlled);
          print('right');
        } else {
          updateDirection(4, playerControlled);
          print('left');
        }
      },
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > 0) {
          updateDirection(3, playerControlled);
          print('down');
        } else {
          updateDirection(1, playerControlled);
          print('up');
        }
      },
      child: Container(
        height: 175,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
                angle: (playerControlled == 1) ? pi : 0,
                child: Column(
                  children: [
                    Text(
                      'PLAYER $playerControlled',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      'S W I P E   T O   P L A Y',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    )
                  ],
                )),
          ],
        ),
        color: (playerControlled == 1) ? Colors.blue : Colors.red,
        width: double.infinity,
      ),
    );
  }
}
