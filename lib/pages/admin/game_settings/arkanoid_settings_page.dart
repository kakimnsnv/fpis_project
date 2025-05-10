import 'package:brick_game/controllers/display_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArkanoidSettingsPage extends StatelessWidget {
  ArkanoidSettingsPage({super.key});

  final DisplayController displayController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Text(
          "BRICK GAME",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
        ),
        Text(
          "ARKANOID",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        Spacer(),
        Row(
          children: [
            newGameButton("MUSIC", () => displayController.changePage(PageType.musicSettings)),
          ],
        ),
        Row(
          children: [
            newGameButton("VIBRATION", () => displayController.changePage(PageType.addGame)),
          ],
        ),
        Row(
          children: [
            newGameButton("STATISTICS", () => displayController.changePage(PageType.addGame)),
          ],
        ),
        Row(
          children: [
            newGameButton("DELETE", () => displayController.changePage(PageType.addGame)),
          ],
        ),
        Spacer(),
      ],
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
