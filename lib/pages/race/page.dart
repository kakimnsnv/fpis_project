import 'package:brick_game/pages/race/controller.dart';
import 'package:brick_game/pages/game_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../game_details.dart';

class RacePage extends StatelessWidget {
  RacePage({super.key});
  final RaceController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Obx(() {
        // controller.updater.value;
        // return GameDisplay(blocks: controller.board.toList());
        // }),
        GameDetails(),
      ],
    );
  }
}
