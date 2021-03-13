import 'package:flutter/material.dart';
import 'package:snake/widgets/gamecontroller.dart';

class Controller extends StatelessWidget {
  final double sizeOfJoyStick;
  final Function updateDirection;
  final int player;

  Controller(this.sizeOfJoyStick, this.updateDirection, this.player);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black87,
      child: Column(
        children: [
          SizedBox(
            height: 10,
            width: double.infinity,
          ),
          Container(
            child: GameController(sizeOfJoyStick, updateDirection, player),
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }
}
