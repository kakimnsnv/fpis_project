import 'dart:async';
import 'dart:math';

import 'package:brick_game/controllers/game_details_controller.dart';
import 'package:get/get.dart';

int speed = 4;

class SnakeController extends GetxController {
  static SnakeController get find => Get.find();
  GameDetailsController gameDetailsController = Get.find();

  RxBool updater = false.obs;

  void onLeft() {
    if (snakeDx == 0) {
      snakeDx = -1;
      snakeDy = 0;
      updater.toggle();
    }
  }

  void onRight() {
    if (snakeDx == 0) {
      snakeDx = 1;
      snakeDy = 0;
      updater.toggle();
    }
  }

  void onUp() {
    if (snakeDy == 0) {
      snakeDy = -1;
      snakeDx = 0;
      updater.toggle();
    }
  }

  void onDown() {
    if (snakeDy == 0) {
      snakeDy = 1;
      snakeDx = 0;
      updater.toggle();
    }
  }

  void onRotate() {}

  static const int gridWidth = 10; // Width: 10 cells as requested
  static const int gridHeight = 25; // Height: 25 cells as requested

  Timer? timer;
  int count = 0;

  // Snake properties
  int snakeX = 4;
  int snakeY = 12;
  int snakeDx = 1;
  int snakeDy = 0;
  List<Point<int>> snakeCells = [];
  int maxCells = 4;

  // Apple property
  Point<int> apple = Point(1, 1);

  void startGame() {
    // TODO: add pause and resume functionality and restart functionality
    snakeCells.add(Point(snakeX, snakeY));

    // Initialize apple position
    apple = Point(getRandomInt(0, gridWidth), getRandomInt(0, gridHeight));

    // Start the game loop
    timer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      gameLoop();
      // TODO: add timer.cancel() when game is over
    });
  }

  // Get random integer in a specific range
  int getRandomInt(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  void gameLoop() {
    // Slow game loop to 15 fps instead of 60 (60/15 = 4)
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
      snakeX = gridWidth - 1;
    } else if (snakeX >= gridWidth) {
      snakeX = 0;
    }

    // Wrap snake position vertically on edge of screen
    if (snakeY < 0) {
      snakeY = gridHeight - 1;
    } else if (snakeY >= gridHeight) {
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
      apple = Point(getRandomInt(0, gridWidth), getRandomInt(0, gridHeight));
    }

    // Check collision with self
    for (int i = 1; i < snakeCells.length; i++) {
      if (snakeX == snakeCells[i].x && snakeY == snakeCells[i].y) {
        // Reset game
        snakeX = 4;
        snakeY = 12;
        snakeCells.clear();
        snakeCells.add(Point(snakeX, snakeY));
        maxCells = 4;
        snakeDx = 1;
        snakeDy = 0;
        apple = Point(getRandomInt(0, gridWidth), getRandomInt(0, gridHeight));
        // TODO: Stop the game loop save the changes
        updater.toggle();
        break;
      }
    }
    updater.toggle();
  }
}
