import 'package:flutter/material.dart';
import 'package:snake/widgets/block.dart';

class GameBoard extends StatelessWidget {
  final int numSquaresAcross;
  final int numSquaresDown;
  final List<int> snake;

  GameBoard(this.numSquaresAcross, this.numSquaresDown, this.snake);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: numSquaresAcross,
          ),
          itemCount: numSquaresAcross * numSquaresDown,
          itemBuilder: (BuildContext context, int index) {
            if (snake.contains(index)) {
              return Block(Colors.blue);
            } else {
              return Block(Colors.grey);
            }
          }),
    );
  }
}
