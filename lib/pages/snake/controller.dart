import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';

var grid = 16;
var count = 0;
int speed = 4;

class SnakeController extends GetxController {
  static SnakeController get find => Get.find();

  RxBool updater = false.obs;

  static const int gridSize = 16;
  static const int gridWidth = 25;
  static const int gridHeight = 25;

  Timer? timer;
  int count = 0;

  int snakeX = 160;
  int snakeY = 160;
  int snakeDx = gridSize;
  int snakeDy = 0;
  List<Point<int>> snakeCells = [];
  int maxCells = 4;

  Point<int> apple = const Point(320, 320);

  void startGame() {
    snakeCells.add(Point(snakeX, snakeY));

    timer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      gameLoop();
      // TODO: add timer?.cancel();
    });
  }

  int getRandomInt(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  void gameLoop() {
    count++;
    if (count < speed) {
      return;
    }
    count = 0;

    // Move snake by its velocity
    snakeX += snakeDx;
    snakeY += snakeDy;

    // Wrap snake position horizontally on edge of screen
    if (snakeX < 0) {
      snakeX = gridWidth * gridSize - gridSize;
    } else if (snakeX >= gridWidth * gridSize) {
      snakeX = 0;
    }

    // Wrap snake position vertically on edge of screen
    if (snakeY < 0) {
      snakeY = gridHeight * gridSize - gridSize;
    } else if (snakeY >= gridHeight * gridSize) {
      snakeY = 0;
    }

    // Keep track of where snake has been. Front of the array is always the head
    snakeCells.insert(0, Point(snakeX, snakeY));

    // Remove cells as we move away from them
    if (snakeCells.length > maxCells) {
      snakeCells.removeLast();
    }

    // Check if snake ate apple
    if (snakeX == apple.x && snakeY == apple.y) {
      maxCells++;
      // Generate new apple position
      apple = Point(getRandomInt(0, gridWidth) * gridSize, getRandomInt(0, gridHeight) * gridSize);
    }

    // Check collision with self
    for (int i = 1; i < snakeCells.length; i++) {
      if (snakeX == snakeCells[i].x && snakeY == snakeCells[i].y) {
        // Reset game
        snakeX = 160;
        snakeY = 160;
        snakeCells.clear();
        snakeCells.add(Point(snakeX, snakeY));
        maxCells = 4;
        snakeDx = gridSize;
        snakeDy = 0;
        apple = Point(getRandomInt(0, gridWidth) * gridSize, getRandomInt(0, gridHeight) * gridSize);
        break;
      }
    }
    updater.toggle();
  }
}
