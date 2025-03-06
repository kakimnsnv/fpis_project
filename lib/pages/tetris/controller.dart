import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

const int ROWS = 25;
const int COLS = 10;
final int speed = 2;

const Map<String, List<List<int>>> tetrominos = {
  'I': [
    [0, 0, 0, 0],
    [1, 1, 1, 1],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
  ],
  'J': [
    [1, 0, 0],
    [1, 1, 1],
    [0, 0, 0],
  ],
  'L': [
    [0, 0, 1],
    [1, 1, 1],
    [0, 0, 0],
  ],
  'O': [
    [1, 1],
    [1, 1],
  ],
  'S': [
    [0, 1, 1],
    [1, 1, 0],
    [0, 0, 0],
  ],
  'Z': [
    [1, 1, 0],
    [0, 1, 1],
    [0, 0, 0],
  ],
  'T': [
    [0, 1, 0],
    [1, 1, 1],
    [0, 0, 0],
  ],
};

// Color mapping for tetrominoes
const Map<String, Color> colors = {
  'I': Colors.cyan,
  'O': Colors.yellow,
  'T': Colors.purple,
  'S': Colors.green,
  'Z': Colors.red,
  'J': Colors.blue,
  'L': Colors.orange,
};

class TetrisController extends GetxController {
  static TetrisController get find => Get.find();

  RxBool updater = false.obs;

  GameState gameState = GameState.initial;

  List<List<String?>> playfield = List.generate(
    ROWS + 2,
    (_) => List.generate(COLS, (_) => null),
  );

  Tetromino tetromino = Tetromino(name: 'I', matrix: tetrominos['I']!, row: -2, col: 3);
  List<String> tetrominoSequence = [];
  int count = 0;

  void startGame() {
    playfield = List.generate(
      ROWS + 2,
      (_) => List.generate(COLS, (_) => null),
    );
    tetromino = Tetromino(name: 'I', matrix: tetrominos['I']!, row: -2, col: 3);
    tetrominoSequence = [];
    count = 0;
    gameState = GameState.playing;

    tetromino = getNextTetromino();
    Timer.periodic(
      Duration(milliseconds: 100),
      (timer) {
        switch (gameState) {
          case GameState.initial:
            break;
          case GameState.playing:
            updateGame();
            break;
          case GameState.paused:
            break;
          case GameState.gameOver:
            timer.cancel();
            break;
        }
      },
    );
  }

  int getRandomInt(int min, int max) {
    return min + Random().nextInt(max - min + 1);
  }

  void generateSequence() {
    tetrominoSequence.clear();
    List<String> sequence = ['I', 'J', 'L', 'O', 'S', 'T', 'Z'];

    while (sequence.isNotEmpty) {
      int rand = getRandomInt(0, sequence.length - 1);
      String name = sequence.removeAt(rand);
      tetrominoSequence.add(name);
    }
  }

  Tetromino getNextTetromino() {
    if (tetrominoSequence.isEmpty) {
      generateSequence();
    }

    String name = tetrominoSequence.removeLast();
    List<List<int>> matrix = tetrominos[name]!;

    int col = (COLS / 2 - (matrix[0].length / 2)).floor();
    int row = name == 'I' ? -1 : -2;

    return Tetromino(
      name: name,
      matrix: matrix,
      row: row,
      col: col,
    );
  }

  List<List<int>> rotate(List<List<int>> matrix) {
    int N = matrix.length - 1;
    return List.generate(matrix.length, (i) => List.generate(matrix.length, (j) => matrix[N - j][i]));
  }

  bool isValidMove(List<List<int>> matrix, int cellRow, int cellCol) {
    for (int row = 0; row < matrix.length; row++) {
      for (int col = 0; col < matrix[row].length; col++) {
        if (matrix[row][col] != 0) {
          int newRow = cellRow + row;
          int newCol = cellCol + col;

          if (newCol < 0 || newCol >= COLS || newRow >= ROWS || (newRow >= 0 && playfield[newRow][newCol] != null)) {
            return false;
          }
        }
      }
    }
    return true;
  }

  void placeTetromino() {
    for (int row = 0; row < tetromino.matrix.length; row++) {
      for (int col = 0; col < tetromino.matrix[row].length; col++) {
        if (tetromino.matrix[row][col] != 0) {
          if (tetromino.row + row < 0) {
            // TODO: add here saving points
            gameState = GameState.gameOver;
            updater.toggle();
            return;
          }

          if (tetromino.row + row >= 0) {
            playfield[tetromino.row + row][tetromino.col + col] = tetromino.name;
          }
        }
      }
    }

    // Clear lines
    for (int row = ROWS - 1; row >= 0;) {
      if (playfield[row].every((cell) => cell != null)) {
        // Remove the line
        playfield.removeAt(row);
        // Add a new empty line at the top
        playfield.insert(0, List.generate(COLS, (_) => null));
      } else {
        row--;
      }
    }

    tetromino = getNextTetromino();
    updater.toggle();
  }

  void updateGame() {
    count++;
    if (count > speed) {
      count = 0;
      tetromino.row++;

      if (!isValidMove(tetromino.matrix, tetromino.row, tetromino.col)) {
        tetromino.row--;
        placeTetromino();
      }
    }
    updater.toggle();
  }

  void moveTetromino(int dx, int dy) {
    if (gameState == GameState.gameOver || gameState == GameState.paused || gameState == GameState.initial) return;

    if (dx != 0) {
      int newCol = tetromino.col + dx;
      if (isValidMove(tetromino.matrix, tetromino.row, newCol)) {
        tetromino.col = newCol;
      }
    }

    if (dy > 0) {
      int newRow = tetromino.row + dy;
      if (!isValidMove(tetromino.matrix, newRow, tetromino.col)) {
        tetromino.row = newRow - 1;
        placeTetromino();
        return;
      }
      tetromino.row = newRow;
    }
    updater.toggle();
  }

  void rotateTetromino() {
    if (gameState == GameState.gameOver || gameState == GameState.paused || gameState == GameState.initial) return;

    List<List<int>> rotatedMatrix = rotate(tetromino.matrix);
    if (isValidMove(rotatedMatrix, tetromino.row, tetromino.col)) {
      tetromino.matrix = rotatedMatrix;
      updater.toggle();
    }
  }
}

enum GameState { initial, playing, paused, gameOver }

class Tetromino {
  String name;
  List<List<int>> matrix;
  int row;
  int col;

  Tetromino({
    required this.name,
    required this.matrix,
    required this.row,
    required this.col,
  });
}
