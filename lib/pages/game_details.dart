import 'package:brick_game/controllers/game_details_controller.dart';
import 'package:brick_game/widgets/block.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameDetails extends StatelessWidget {
  GameDetails({super.key});

  final GameDetailsController controller = Get.put(GameDetailsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("SCORE"),
        Text("${controller.score}"),
        SizedBox(height: 10),
        Text("HI-SCORE"),
        Text("${controller.hiScore}"),
        SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width / 5,
          height: MediaQuery.of(context).size.width / 5,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
            ),
            itemCount: 4 * 4,
            itemBuilder: (context, index) {
              return Block(BlockType.empty);
            },
          ),
        ),
        SizedBox(height: 10),
        Text("SPEED"),
        Text("${controller.speed}"),
        SizedBox(height: 10),
        Text("GOAL"),
        Text("${controller.currentGoal}/${controller.goal}"),
        SizedBox(height: 10),
        Text("LEVEL"),
        Text("${controller.level}"),
      ],
    );
  }
}
