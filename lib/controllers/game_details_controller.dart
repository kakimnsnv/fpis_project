import 'package:get/get.dart';

class GameDetailsController extends GetxController {
  static GameDetailsController get find => Get.find();

  RxInt score = 0.obs;
  RxInt hiScore = 0.obs;
  RxInt goal = 0.obs;
  RxInt currentGoal = 0.obs;
  RxInt level = 1.obs;
  RxInt speed = 1.obs;
  // TODO: add next brick
}
