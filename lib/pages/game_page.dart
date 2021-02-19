import 'package:flutter/material.dart';
import 'package:snake/widgets/controller.dart';
import 'package:snake/widgets/game_board.dart';
import 'dart:async';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final int numSquaresAcross = 21;
  final int numSquaresDown = 25;

  final int initSnakeLength = 3;

  int dir = 2;
  int snakeDir;
  List<int> snake = [0];

  @override
  void initState() {
    super.initState();

    snakeDir = dir;
    generateSnakes();
    Timer.periodic(Duration(milliseconds: 300), (Timer timer) {
      updateSnake();
    });
  }

  void generateSnakes() {
    for (int i = 1; i < initSnakeLength; i++) {
      snake.add(snake.last + numSquaresAcross);
    }
  }

  void updateSnake() {
    updateSnakeDirection();
    setState(() {
      switch (snakeDir) {
        case 3:
          snake.add((snake.last + numSquaresAcross) %
              (numSquaresAcross * numSquaresDown));
          break;
        case 1:
          snake.add((snake.last - numSquaresAcross) %
              (numSquaresAcross * numSquaresDown));
          break;
        case 2:
          if ((snake.last + 1) % numSquaresAcross == 0) {
            snake.add(snake.last - numSquaresAcross + 1);
          } else {
            snake.add(snake.last + 1);
          }
          break;
        case 4:
          if (snake.last % numSquaresAcross == 0) {
            snake.add(snake.last + numSquaresAcross - 1);
          } else {
            snake.add(snake.last - 1);
          }
          break;
        default:
          snake.add((snake.last + numSquaresAcross) %
              (numSquaresAcross * numSquaresDown));
      }
      if (snake.length > 1) {
        setState(() {
          snake.removeAt(0);
        });
      }
    });

    // print('snake being updated');
  }

  void updateSnakeDirection() {
    if (snakeDir != ((dir + 2) % 4)) {
      snakeDir = dir;
    }
  }

  void updateToggleDirection(double angle) {
    if (angle != 0.0) {
      dir = (((angle + 45) % 360) / 90).ceil();
      return;
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final sizeOfJoyStick =
        (deviceHeight - (deviceWidth / numSquaresAcross * numSquaresDown)) *
            0.4;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Controller(sizeOfJoyStick, updateToggleDirection),
          GameBoard(numSquaresAcross, numSquaresDown, snake),
          Controller(sizeOfJoyStick, updateToggleDirection),
        ],
      ),
    );
  }
}
