import 'package:brick_game/pages/auth/auth_page_controller.dart';
import 'package:brick_game/styles/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthPageController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("BRICK GAME", style: tsText),
        Spacer(),
        GestureDetector(
          onTap: () => controller.toLogin(),
          child: Text("LOGIN", style: tsText),
        ),
        GestureDetector(
          onTap: () => controller.toRegister(),
          child: Text("REGISTER", style: tsText),
        ),
        Spacer(),
      ],
    );
  }
}
