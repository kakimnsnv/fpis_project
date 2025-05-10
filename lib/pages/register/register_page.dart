import 'package:brick_game/pages/register/register_page_controller.dart';
import 'package:brick_game/styles/typography.dart';
import 'package:brick_game/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterPageController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("BRICK GAME", style: tsText),
        Spacer(flex: 2),
        CustomTextField(label: "EMAIL", controller: controller.emailController),
        Spacer(),
        CustomTextField(label: "USERNAME", controller: controller.usernameController),
        Spacer(),
        CustomTextField(label: "PASSWORD", controller: controller.passwordController),
        Spacer(flex: 2),
        GestureDetector(
          onTap: () => controller.register(),
          child: Text("REGISTER", style: tsText),
        ),
        Spacer(flex: 2),
        GestureDetector(
          onTap: () => controller.toLogin(),
          child: Text("I ALREADY HAVE AN ACCOUNT", style: tsTextSm),
        ),
        Spacer(),
      ],
    );
  }
}
