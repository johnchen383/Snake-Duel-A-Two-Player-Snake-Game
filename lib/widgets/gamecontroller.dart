import 'package:flutter/material.dart';
import 'package:snake/widgets/taparea.dart';
import 'dart:math';

class GameController extends StatelessWidget {
  final double sizeOfJoystick;
  final Function whenTapped;
  final int player;

  GameController(this.sizeOfJoystick, this.whenTapped, this.player);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 30),
      child: Transform.rotate(
        angle: pi / 4,
        // origin: Offset(sizeOfJoystick / 2, sizeOfJoystick / 2),
        child: Container(
          margin: EdgeInsets.all(5),
          height: sizeOfJoystick,
          width: sizeOfJoystick,
          child: Column(
            children: [
              Row(
                children: [
                  TapArea(sizeOfJoystick, whenTapped, 1, player),
                  TapArea(sizeOfJoystick, whenTapped, 2, player),
                ],
              ),
              Row(
                children: [
                  TapArea(sizeOfJoystick, whenTapped, 4, player),
                  TapArea(sizeOfJoystick, whenTapped, 3, player),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
