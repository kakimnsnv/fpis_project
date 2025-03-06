import 'package:brick_game/pages/tetris/controller.dart';
import 'package:brick_game/pages/game_details.dart';
import 'package:brick_game/widgets/block.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TetrisPage extends StatelessWidget {
  TetrisPage({super.key});

  final TetrisController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2.36,
          child: Obx(() {
            final bool u = controller.updater.value;
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: COLS,
                childAspectRatio: 1,
              ),
              itemCount: ROWS * COLS,
              itemBuilder: (context, index) {
                int row = index ~/ COLS;
                int col = index % COLS;

                Color? cellColor;
                String? cellName = controller.playfield[row][col];

                // Add current tetromino to visualization
                if (controller.gameState != GameState.gameOver) {
                  int tetrominoLocalRow = row - controller.tetromino.row;
                  int tetrominoLocalCol = col - controller.tetromino.col;

                  if (tetrominoLocalRow >= 0 &&
                      tetrominoLocalRow < controller.tetromino.matrix.length &&
                      tetrominoLocalCol >= 0 &&
                      tetrominoLocalCol < controller.tetromino.matrix[0].length &&
                      controller.tetromino.matrix[tetrominoLocalRow][tetrominoLocalCol] != 0) {
                    cellName = controller.tetromino.name;
                  }
                }

                cellColor = cellName != null ? colors[cellName] : null;

                return Block(cellName != null ? BlockType.filled : BlockType.empty);
              },
            );
          }),
        ),
        GameDetails(),
      ],
    );
  }
}
