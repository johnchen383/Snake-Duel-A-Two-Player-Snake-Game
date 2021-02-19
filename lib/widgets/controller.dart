import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';

class Controller extends StatelessWidget {
  final double sizeOfJoyStick;
  final Function updateDirection;

  Controller(this.sizeOfJoyStick, this.updateDirection);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.black,
        child: JoystickView(
          showArrows: false,
          size: sizeOfJoyStick,
          backgroundColor: Colors.red,
          innerCircleColor: Colors.orange,
          onDirectionChanged: (double angle, _) {
            updateDirection(angle);
          },
          opacity: 0.7,
          interval: null,
        ),
      ),
    );
  }
}
