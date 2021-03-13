import 'package:flutter/material.dart';
import 'package:snake/widgets/block.dart';

class GameBoard extends StatelessWidget {
  final int numSquaresAcross;
  final int numSquaresDown;
  final List<int> snake1;
  final List<int> snake2;
  final List<int> food;

  GameBoard(this.numSquaresAcross, this.numSquaresDown, this.snake1,
      this.snake2, this.food);

  Color createColour(Color originalColour, double frac) {
    return Color.fromARGB(
      originalColour.alpha,
      (originalColour.red * frac).round(),
      (originalColour.green * frac).round(),
      (originalColour.blue * frac).round(),
    );
  }

  Block snakeBlocks(List<int> snake, int index, Color colour) {
    int head = snake.last;
    List<int> body = snake.sublist(snake.length - 4, snake.length - 1);
    List<int> tail = snake.sublist(0, snake.length - 4);

    if (tail.contains(index)) {
      return Block(createColour(colour, 0.3));
    } else if (body.contains(index)) {
      return Block(createColour(colour, 0.75));
    } else if (head == index) {
      return Block(colour);
    }

    return null;
  }

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
            Color foodColour = Color(0xFF39FF14);
            Color p1Colour = Color(0xFF1F51FF);
            Color p2Colour = Colors.red;

            if (snake1.contains(index)) {
              return snakeBlocks(snake1, index, p1Colour);
            }
            if (snake2.contains(index)) {
              return snakeBlocks(snake2, index, p2Colour);
            }

            if (food.contains(index)) {
              return Block(foodColour);
            } else {
              return Block(null);
            }
          }),
    );
  }
}
