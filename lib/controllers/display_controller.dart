import 'package:brick_game/pages/admin/add_game/add_game_page.dart';
import 'package:brick_game/pages/admin/game_settings/arkanoid_settings_page.dart';
import 'package:brick_game/pages/admin/game_settings/race_settings_page.dart';
import 'package:brick_game/pages/admin/game_settings/snake_settings_page.dart';
import 'package:brick_game/pages/admin/game_settings/tetris_settings_page.dart';
import 'package:brick_game/pages/admin/page.dart';
import 'package:brick_game/pages/admin/users/users_page.dart';
import 'package:brick_game/pages/arkanoid/controller.dart';
import 'package:brick_game/pages/arkanoid/page.dart';
import 'package:brick_game/pages/auth/auth_page.dart';
import 'package:brick_game/pages/login/login_page.dart';
import 'package:brick_game/pages/race/controller.dart';
import 'package:brick_game/pages/register/register_page.dart';
import 'package:brick_game/pages/snake/controller.dart';
import 'package:brick_game/pages/tetris/controller.dart';
import 'package:brick_game/pages/leader_board/page.dart';
import 'package:brick_game/pages/menu/page.dart';
import 'package:brick_game/pages/race/page.dart';
import 'package:brick_game/pages/snake/page.dart';
import 'package:brick_game/pages/tetris/page.dart';
import 'package:brick_game/services/api_service.dart';
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
      case PageType.musicSettings:
        controlls.value = controlls.value.addGame;
        return AddGamePage();
      case PageType.tetrisSettings:
        controlls.value = controlls.value.tetrisSettings;
        return TetrisSettingsPage();
      case PageType.raceSettings:
        controlls.value = controlls.value.raceSettings;
        return RaceSettingsPage();
      case PageType.snakeSettings:
        controlls.value = controlls.value.snakeSettings;
        return SnakeSettingsPage();
      case PageType.arkanoidSettings:
        controlls.value = controlls.value.arkanoidSettings;
        return ArkanoidSettingsPage();
      case PageType.users:
        controlls.value = controlls.value.users;
        return UsersPage();
      case PageType.addGame:
        controlls.value = controlls.value.addGame;
        return AddGamePage();
      case PageType.admin:
        controlls.value = controlls.value.admin;
        return AdminPage();
      case PageType.auth:
        controlls.value = controlls.value.auth;
        return AuthPage();
      case PageType.login:
        controlls.value = controlls.value.login;
        return LoginPage();
      case PageType.register:
        controlls.value = controlls.value.register;
        return RegisterPage();
      case PageType.menu:
        controlls.value = controlls.value.menu;
        return MenuPage();
      case PageType.leaderBoard:
        controlls.value = controlls.value.leaderBoard;
        return LeaderBoardPage();
      case PageType.tetris:
        controlls.value = controlls.value.tetris;
        return TetrisPage();
      case PageType.settings:
        controlls.value = controlls.value.settings;
        return MenuPage(); // TODO: remove
      case PageType.snake:
        controlls.value = controlls.value.snake;
        return SnakePage();
      case PageType.arkanoid:
        controlls.value = controlls.value.arkanoid;
        return ArkanoidPage();
      case PageType.race:
        controlls.value = controlls.value.race;
        return RacePage();
    }
  }
}

enum PageType {
  auth,
  login,
  register,
  menu,
  leaderBoard,
  settings,
  tetris,
  snake,
  arkanoid,
  race,
  admin,
  users,
  addGame,
  tetrisSettings,
  arkanoidSettings,
  raceSettings,
  snakeSettings,
  musicSettings,
}

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
  ArkanoidController? arkanoidController;

  setup() {
    raceController ??= Get.find<RaceController>();
    displayController ??= Get.find<DisplayController>();
    tetrisController ??= Get.find<TetrisController>();
    snakeController ??= Get.find<SnakeController>();
    arkanoidController ??= Get.find<ArkanoidController>();
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
      onExit: () {
        Get.find<ApiService>().logout();
      },
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

  Controlls get auth {
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
      onExit: () {},
    );
  }

  Controlls get admin {
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

  Controlls get addGame {
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
        displayController?.changePage(PageType.admin);
      },
    );
  }

  Controlls get users {
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
        displayController?.changePage(PageType.admin);
      },
    );
  }

  Controlls get tetrisSettings {
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
        displayController?.changePage(PageType.admin);
      },
    );
  }

  Controlls get raceSettings {
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
        displayController?.changePage(PageType.admin);
      },
    );
  }

  Controlls get snakeSettings {
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
        displayController?.changePage(PageType.admin);
      },
    );
  }

  Controlls get arkanoidSettings {
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
        displayController?.changePage(PageType.admin);
      },
    );
  }

  Controlls get login {
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
        displayController?.changePage(PageType.auth);
      },
    );
  }

  Controlls get register {
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
        displayController?.changePage(PageType.auth);
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
        switch (snakeController?.gameState ?? GameState.initial) {
          case GameState.initial || GameState.gameOver:
            snakeController?.init();
            snakeController?.startGame();
            break;
          case GameState.playing:
            snakeController?.gameState = GameState.paused;
            break;
          case GameState.paused:
            snakeController?.gameState = GameState.playing;
            break;
        }
      },
      onSound: null,
      onSettings: null,
      onExit: () {
        snakeController?.gameState = GameState.paused;
        displayController?.changePage(PageType.menu);
      },
    );
  }

  Controlls get arkanoid {
    setup();
    return Controlls(
      onUp: null,
      onDown: null,
      onLeft: () {
        arkanoidController?.movePaddle(-1);
      },
      onRight: () {
        arkanoidController?.movePaddle(1);
      },
      onRotate: null,
      onStart: () {
        switch (arkanoidController?.gameState ?? GameState.initial) {
          case GameState.initial || GameState.gameOver:
            arkanoidController?.init();
            arkanoidController?.startGame();
            break;
          case GameState.playing:
            arkanoidController?.gameState = GameState.paused;
            break;
          case GameState.paused:
            arkanoidController?.gameState = GameState.playing;
            break;
        }
      },
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
      onUp: null,
      onDown: null,
      onLeft: () {
        raceController?.movePlayerCar(-1);
      },
      onRight: () {
        raceController?.movePlayerCar(1);
      },
      onRotate: () {},
      onStart: () {
        switch (raceController?.gameState ?? GameState.initial) {
          case GameState.initial || GameState.gameOver:
            raceController?.init();
            raceController?.startGame();
            break;
          case GameState.playing:
            raceController?.gameState = GameState.paused;
            break;
          case GameState.paused:
            raceController?.gameState = GameState.playing;
            break;
        }
      },
      onSound: () {},
      // onSettings: () => displayController?.changePage(PageType.settings),
      onExit: () {
        raceController?.gameState = GameState.paused;
        displayController?.changePage(PageType.menu);
      },
    );
  }
}
