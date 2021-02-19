import 'package:flutter/material.dart';

class Block extends StatelessWidget {
  final Color colour;

  Block(this.colour);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color: colour,
          ),
        ),
      ),
    );
  }
}
