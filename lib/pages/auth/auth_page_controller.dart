import 'package:brick_game/controllers/display_controller.dart';
import 'package:get/get.dart';

class AuthPageController extends GetxController {
  toLogin() {
    Get.find<DisplayController>().changePage(PageType.login);
  }

  toRegister() {
    Get.find<DisplayController>().changePage(PageType.register);
  }
}
