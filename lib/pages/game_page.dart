import 'package:flutter/material.dart';
import 'package:snake/widgets/controller.dart';
import 'package:snake/widgets/game_board.dart';
import 'dart:async';
import 'dart:math';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final int numSquaresAcross = 21;
  final int numSquaresDown = 25;

  final int initSnakeLength = 5;

  int gameOver;
  int snakeDir1;
  int snakeDir2;

  int dir1 = 3;
  int dir2 = 1;
  List<int> snake1 = [10];
  List<int> snake2 = [514];
  List<int> food = [262];

  @override
  void initState() {
    super.initState();

    gameOver = 0;

    startGame();
  }

  void startGame() {
    dir1 = 3;
    snake1 = [10];

    dir2 = 1;
    snake2 = [514];

    food = [262];

    snakeDir1 = dir1;
    snakeDir2 = dir2;
    generateSnakes();
    Timer.periodic(Duration(milliseconds: 250), (Timer timer) {
      if (gameOver == 0) {
        updateSnake(snake1, snakeDir1);
        updateSnake(snake2, snakeDir2);
        if (timer.tick % 10 == 0) {
          if (food.length < 3) {
            food.add(addItem());
          }
        }
      } else {
        showGameOver();
        timer.cancel();
      }
    });
  }

  void generateSnakes() {
    for (int i = 1; i < initSnakeLength; i++) {
      snake1.add(snake1.last + numSquaresAcross);
    }
    for (int i = 1; i < initSnakeLength; i++) {
      snake2.add(snake2.last - numSquaresAcross);
    }
  }

  void updateSnake(List<int> snake, int snakeDir) {
    bool isSnake1 = snake == snake1;
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
      if (snake.length > 1 && !food.contains(snake.last)) {
        setState(() {
          snake.removeAt(0);
        });
      }

      if (food.contains(snake.last)) {
        //eaten food!!
        food.removeWhere((element) => element == snake.last);
        food.add(addItem());
      }

      if (cannibal(snake)) {
        gameOver = (isSnake1) ? 1 : 4;
      }

      if (isSnake1) {
        if (snake2.sublist(0, snake2.length - 2).contains(snake1.last)) {
          //snake1 ate snake 2
          gameOver = 2;
        }
      } else {
        if (snake1.sublist(0, snake1.length - 2).contains(snake2.last)) {
          //snake2 ate snake 1
          gameOver = 5;
        }

        if (snake1.last == snake2.last) {
          gameOver = 7;
        }
      }
    });

    // print('snake being updated');
  }

  Text alertContent() {
    if (gameOver >= 4 && gameOver < 7) {
      return Text('Player 1 Won!');
    } else if (gameOver <= 3 && gameOver > 0) {
      return Text('Player 2 Won!');
    } else {
      return Text('Its a tie!');
    }
  }

  Future<void> showGameOver() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('GAME OVER'),
          content: alertContent(),
          actions: <Widget>[
            TextButton(
              child: Text('PLAY AGAIN'),
              onPressed: () {
                Navigator.of(context).pop();
                gameOver = 0;
                startGame();
              },
            ),
          ],
        );
      },
    );
  }

  bool cannibal(List<int> thisSnake) {
    for (int i = 0; i < thisSnake.length; i++) {
      if (thisSnake.where((element) => element == thisSnake[i]).length >= 2) {
        return true;
      }
    }

    return false;
  }

  int addItem() {
    List<int> items = getAllItems();
    int numspaces = numSquaresAcross * numSquaresDown;
    int initNum = Random().nextInt(numspaces - items.length);

    for (int i = 0; i <= items.length; i++) {
      int numInstanceBefore =
          items.where((element) => element <= initNum + i).length;
      if (numInstanceBefore == i) {
        return initNum + i;
      }
    }
    return null;
  }

  List<int> getAllItems() {
    List<int> items = [];
    items.addAll(snake1);
    items.addAll(snake2);

    return items;
  }

  void updateSnakeDirection() {
    if (snakeDir1 != (((dir1 + 1) % 4) + 1)) {
      snakeDir1 = dir1;
    }

    if (snakeDir2 != (((dir2 + 1) % 4) + 1)) {
      snakeDir2 = dir2;
    }
  }

  void updateToggleDirection(int direction, int player) {
    if (player == 1) {
      dir1 = direction;
    } else {
      dir2 = direction;
    }
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
          Expanded(
            child: Transform.rotate(
              angle: pi,
              child: Controller(sizeOfJoyStick, updateToggleDirection, 2),
            ),
          ),
          GameBoard(numSquaresAcross, numSquaresDown, snake1, snake2, food),
          Expanded(
            child: Controller(sizeOfJoyStick, updateToggleDirection, 1),
          ),
        ],
      ),
    );
  }
}
