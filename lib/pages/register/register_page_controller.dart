import 'package:brick_game/controllers/display_controller.dart';
import 'package:brick_game/services/api_service.dart';
import 'package:brick_game/services/dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPageController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  toLogin() {
    Get.find<DisplayController>().changePage(PageType.login);
  }

  register() {
    if (usernameController.value.text.isEmpty || passwordController.value.text.isEmpty || emailController.value.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }
    Get.find<ApiService>().register(RegisterDTO(password: passwordController.value.text, username: usernameController.value.text, email: emailController.value.text));
  }
}
