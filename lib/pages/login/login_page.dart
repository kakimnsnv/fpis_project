import 'package:brick_game/pages/login/login_page_controller.dart';
import 'package:brick_game/styles/typography.dart';
import 'package:brick_game/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginPageController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("BRICK GAME", style: tsText),
        Spacer(),
        CustomTextField(label: "USERNAME", controller: controller.usernameController),
        Spacer(),
        CustomTextField(label: "PASSWORD", controller: controller.passwordController),
        Spacer(),
        GestureDetector(
          onTap: () => controller.login(),
          child: Text("LOG IN", style: tsText),
        ),
        Spacer(),
        GestureDetector(
          onTap: () => controller.toRegister(),
          child: Text("I DON'T HAVE AN ACCOUNT", style: tsTextSm),
        ),
        Spacer(),
      ],
    );
  }
}
