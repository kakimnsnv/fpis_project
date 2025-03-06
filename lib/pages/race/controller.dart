import 'package:get/get.dart';

class RaceController extends GetxController {
  static RaceController get find => Get.find();

  RxList<RxList<int>> board = List.generate(25, (index) => List.filled(10, 0).obs).obs;

  RxBool pause = false.obs;
  RxBool updater = false.obs;

  start() {
    createObstacle(true);
  }

  void createObstacle(bool isLeft) {
    final int startingPos = isLeft ? 1 : 5;
    board[0][startingPos] = 1;

    updater.value = !updater.value;
  }

  void onLeft() {}
  void onStartButton() {
    start();
  }

  void onUp() {}
  void onRight() {}
  void onDown() {}
  void onRotate() {}
  void onPause() {}

  bool isEmpty(int x, int y) {
    return board[x][y] == 0;
  }
}
// For Block
//0 is empty
//1 is filled
//2 is moving
//3 is predicted
