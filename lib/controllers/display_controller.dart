import 'package:brick_game/pages/race/controller.dart';
import 'package:brick_game/pages/snake/controller.dart';
import 'package:brick_game/pages/tetris/controller.dart';
import 'package:brick_game/pages/leader_board/page.dart';
import 'package:brick_game/pages/menu/page.dart';
import 'package:brick_game/pages/race/page.dart';
import 'package:brick_game/pages/snake/page.dart';
import 'package:brick_game/pages/tetris/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayController extends GetxController {
  static DisplayController get find => Get.find();

  RxInt currentPage = 0.obs;
  Rx<Controlls> controlls = Controlls().obs;

  void changePage(PageType page) {
    currentPage.value = page.index;
  }

  Widget getContent() {
    switch (PageType.values[currentPage.value]) {
      case PageType.menu:
        controlls.value = controlls.value.menu;
        return MenuPage();
      case PageType.leaderBoard:
        controlls.value = controlls.value.leaderBoard;
        return LeaderBoardPage();
      case PageType.tetris:
        controlls.value = controlls.value.tetris;
        return TetrisPage(); // TODO: remove
      case PageType.settings:
        controlls.value = controlls.value.settings;
        return MenuPage(); // TODO: remove
      case PageType.snake:
        controlls.value = controlls.value.snake;
        return SnakePage();
      case PageType.arkanoid:
        controlls.value = controlls.value.arkanoid;
        return MenuPage(); // TODO: remove
      case PageType.race:
        controlls.value = controlls.value.race;
        return RacePage();
    }
  }
}

enum PageType { menu, leaderBoard, settings, tetris, snake, arkanoid, race }

class Controlls {
  final Function()? onUp;
  final Function()? onDown;
  final Function()? onLeft;
  final Function()? onRight;
  final Function()? onRotate;
  final Function()? onStart;
  final Function()? onSound;
  final Function()? onSettings;
  final Function()? onExit;

  Controlls({
    this.onUp,
    this.onDown,
    this.onLeft,
    this.onRight,
    this.onRotate,
    this.onStart,
    this.onSound,
    this.onSettings,
    this.onExit,
  });

  RaceController? raceController;
  DisplayController? displayController;
  TetrisController? tetrisController;
  SnakeController? snakeController;

  setup() {
    raceController ??= Get.find<RaceController>();
    displayController ??= Get.find<DisplayController>();
    tetrisController ??= Get.find<TetrisController>();
    snakeController ??= Get.find<SnakeController>();
  }

  Controlls get menu {
    setup();
    return Controlls(
      onUp: null,
      onDown: null,
      onLeft: null,
      onRight: null,
      onRotate: null,
      onStart: null,
      onSound: null,
      onSettings: null,
      onExit: null,
    );
  }

  Controlls get leaderBoard {
    setup();
    return Controlls(
      onUp: null,
      onDown: null,
      onLeft: null,
      onRight: null,
      onRotate: null,
      onStart: null,
      onSound: null,
      onSettings: null,
      onExit: () {
        displayController?.changePage(PageType.menu);
      },
    );
  }

  Controlls get settings {
    setup();
    return Controlls(
      onUp: null,
      onDown: null,
      onLeft: null,
      onRight: null,
      onRotate: null,
      onStart: null,
      onSound: null,
      onSettings: null,
      onExit: null,
    );
  }

  Controlls get tetris {
    setup();
    return Controlls(
      onUp: () {
        tetrisController?.onUp();
      },
      onDown: () {
        tetrisController?.moveTetromino(0, 1);
      },
      onLeft: () {
        tetrisController?.moveTetromino(-1, 0);
      },
      onRight: () {
        tetrisController?.moveTetromino(1, 0);
      },
      onRotate: () {
        tetrisController?.rotateTetromino();
      },
      onStart: () {
        switch (tetrisController?.gameState ?? GameState.initial) {
          case GameState.initial || GameState.gameOver:
            tetrisController?.init();
            tetrisController?.startGame();
            break;
          case GameState.playing:
            tetrisController?.gameState = GameState.paused;
            break;
          case GameState.paused:
            tetrisController?.gameState = GameState.playing;
            break;
        }
      },
      onSound: null,
      onSettings: null,
      onExit: () {
        tetrisController?.gameState = GameState.paused;
        displayController?.changePage(PageType.menu);
      },
    );
  }

  Controlls get snake {
    setup();
    return Controlls(
      onUp: () {
        snakeController?.onUp();
      },
      onDown: () {
        snakeController?.onDown();
      },
      onLeft: () {
        snakeController?.onLeft();
      },
      onRight: () {
        snakeController?.onRight();
      },
      onRotate: null,
      onStart: () {
        snakeController?.startGame();
      },
      onSound: null,
      onSettings: null,
      onExit: () {
        // Pause
        displayController?.changePage(PageType.menu);
      },
    );
  }

  Controlls get arkanoid {
    setup();
    return Controlls(
      onUp: null,
      onDown: null,
      onLeft: null,
      onRight: null,
      onRotate: null,
      onStart: null,
      onSound: null,
      onSettings: null,
      onExit: () {
        displayController?.changePage(PageType.menu);
      },
    );
  }

  Controlls get race {
    setup();
    return Controlls(
      onUp: raceController?.onUp.call,
      onDown: raceController?.onDown.call,
      onLeft: raceController?.onLeft.call,
      onRight: raceController?.onRight.call,
      onRotate: raceController?.onRotate.call,
      onStart: raceController?.onStartButton.call,
      onSound: () {},
      onSettings: () => displayController?.changePage(PageType.settings),
      onExit: () => displayController?.changePage(PageType.menu),
    );
  }
}
