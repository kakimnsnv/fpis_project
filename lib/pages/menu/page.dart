import 'package:brick_game/controllers/display_controller.dart';
import 'package:brick_game/services/api_service.dart';
import 'package:brick_game/services/dto.dart';
import 'package:brick_game/widgets/block.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPage extends StatelessWidget {
  MenuPage({super.key});

  final DisplayController displayController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        Text(
          "BRICK GAME",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
        ),
        Row(
          children: [
            newMenuButton("MENU", null, isFilled: true),
            Spacer(),
            newMenuButton("LEADER\nBOARD", () => displayController.changePage(PageType.leaderBoard)),
          ],
        ),
        if (Get.find<ApiService>().isAdmin)
          Row(
            children: [
              newGameButton("ADMIN PANEL", () => displayController.changePage(PageType.admin)),
            ],
          ),
        Spacer(),
        if (Get.find<ApiService>().games.firstWhere((el) => el.name == "Race", orElse: () => Game(id: '', name: '', sound: '')).name != "")
          Row(
            children: [
              newGameButton("RACE", () => displayController.changePage(PageType.race)),
            ],
          ),
        if (Get.find<ApiService>().games.firstWhere((el) => el.name == "Tetris", orElse: () => Game(id: '', name: '', sound: '')).name != "")
          Row(
            children: [
              newGameButton("TETRIS", () => displayController.changePage(PageType.tetris)),
            ],
          ),
        if (Get.find<ApiService>().games.firstWhere((el) => el.name == "Snake", orElse: () => Game(id: '', name: '', sound: '')).name != "")
          Row(
            children: [
              newGameButton("SNAKE", () => displayController.changePage(PageType.snake)),
            ],
          ),
        if (Get.find<ApiService>().games.firstWhere((el) => el.name == "Arkanoid", orElse: () => Game(id: '', name: '', sound: '')).name != "")
          Row(
            children: [
              newGameButton("ARKANOID", () => displayController.changePage(PageType.arkanoid)),
            ],
          ),
        Spacer(),
      ],
    );
  }

  GestureDetector newMenuButton(String text, Function()? onTap, {bool isFilled = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 15,
            height: 15,
            child: Expanded(child: Block(isFilled ? BlockType.filled : BlockType.empty)),
          ),
          SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget newGameButton(String text, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      ).paddingSymmetric(vertical: 10),
    );
  }
}
