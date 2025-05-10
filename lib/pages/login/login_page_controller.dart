import 'package:brick_game/controllers/display_controller.dart';
import 'package:brick_game/services/api_service.dart';
import 'package:brick_game/services/dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  toRegister() {
    Get.find<DisplayController>().changePage(PageType.register);
  }

  login() {
    if (usernameController.value.text.isEmpty || passwordController.value.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }
    Get.find<ApiService>().login(LoginDTO(password: passwordController.value.text, username: usernameController.value.text));
  }
}
