import 'package:brick_game/pages/leader_board/controller.dart';
import 'package:brick_game/styles/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaderBoardPage extends StatelessWidget {
  const LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaderBoardPageController());
    return Column(
      children: [
        Text("HIGH SCORE", style: tsText),
        GetBuilder<LeaderBoardPageController>(
            initState: (_) {},
            builder: (_) {
              if (controller.score.value != null && controller.score.value!.length > 0) return Text("${controller.score.value![0].score}", style: tsTextSm);
              return SizedBox.shrink();
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  controller.changeGame(false);
                },
                icon: Icon(Icons.arrow_back_ios)),
            Obx(() => Text(
                  controller.currentGame.value.name,
                )),
            IconButton(
                onPressed: () {
                  controller.changeGame(true);
                },
                icon: Icon(Icons.arrow_forward_ios))
          ],
        ),
        GetBuilder<LeaderBoardPageController>(
          initState: (_) {},
          builder: (_) {
            return Table(
              children: [
                TableRow(children: [
                  Text("USER"),
                  Text("Score"),
                ]),
                if (controller.score.value != null) ...controller.score.value!.map((score) => TableRow(children: [Text("${score.userName}", style: tsTextSm), Text("${score.score}", style: tsTextSm)])),
              ],
            );
          },
        ),
      ],
    );
  }
}
