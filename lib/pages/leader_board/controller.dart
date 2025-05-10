import 'package:brick_game/services/api_service.dart';
import 'package:brick_game/services/dto.dart';
import 'package:get/get.dart';

class LeaderBoardPageController extends GetxController {
  final int highScore = 0;

  RxInt game = 0.obs;
  Rx<Game> currentGame = Get.find<ApiService>().games[0].obs;
  Rx<List<Score>?> score = Rx<List<Score>>([]);

  @override
  void onInit() async {
    score.value = await Get.find<ApiService>().getScoreByGameID(Get.find<ApiService>().games[game.value]);
    super.onInit();
  }

  void changeGame(bool next) async {
    game.value = next
        ? game.value < 3
            ? ++game.value
            : 3
        : game.value > 1
            ? --game.value
            : 0;
    currentGame.value = Get.find<ApiService>().games[game.value];
    score.value = await Get.find<ApiService>().getScoreByGameID(currentGame.value);
    update();
  }
}
