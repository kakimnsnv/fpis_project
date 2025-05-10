import 'package:brick_game/services/api_service.dart';
import 'package:brick_game/styles/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("BRICK GAME", style: tsText),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("MAKE ADMIN", style: tsTextSm),
            Text("USER", style: tsTextSm),
            Text("DELETE", style: tsTextSm),
          ],
        ),
        ...Get.find<ApiService>().users.map(
              (e) => Row(
                spacing: 10,
                children: [
                  IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () {
                      Get.find<ApiService>().makeAdmin(e);
                    },
                  ),
                  Spacer(),
                  Text(e.username, style: tsTextSm),
                  Text(e.email, style: tsTextSm),
                  Spacer(),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      Get.find<ApiService>().deleteUser(e.id);
                    },
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
