import 'package:brick_game/controllers/display_controller.dart';
import 'package:brick_game/services/dto.dart';
import 'package:get/get.dart';

class ApiService extends GetConnect {
  String token = '';
  bool isAdmin = false;
  List<Game> games = [];
  List<User> users = [];

  void onInit() {
    httpClient.baseUrl = 'http://localhost:8080';
    httpClient.addRequestModifier<Object?>((request) {
      request.headers['Authorization'] = token;
      return request;
    });
  }

  Future<void> logout() async {
    token = "";
    isAdmin = false;
    games = [];
    Get.find<DisplayController>().changePage(PageType.auth);
  }

  Future<void> register(RegisterDTO req) async {
    final response = await post('/users/register', req.toJson());
    if (response.status.hasError) {
      Get.snackbar("Registration error", response.statusText ?? "");
    } else {
      Get.snackbar("Registration success", "User registered successfully");
      token = response.body['token'];
      isAdmin = response.body['roles'].contains('admin');
      await getGames();
      // Get.find<DisplayController>().changePage(PageType.menu);
    }
  }

  Future<void> login(LoginDTO user) async {
    final response = await post('/users/login', user.toJson());
    if (response.status.hasError) {
      Get.snackbar("Login error", response.statusText ?? "");
    } else {
      Get.snackbar("Login success", "OK");
      token = response.body['token'];
      isAdmin = response.body['roles'].contains('admin');
      await getGames();
      // Get.find<DisplayController>().changePage(PageType.menu);
    }
  }

  Future<void> getGames() async {
    final response = await get('/games');
    if (response.status.hasError) {
      Get.snackbar("Error", response.statusText ?? "");
    } else {
      games = (response.body as List).map((game) => Game.fromJson(game)).toList();
      Get.find<DisplayController>().changePage(PageType.menu);
      await getUsers();
    }
  }

  Future<void> getUsers() async {
    final response = await get('/users');
    if (response.status.hasError) {
      Get.snackbar("Error", response.statusText ?? "");
    } else {
      users = (response.body as List).map((user) => User.fromJson(user)).toList();
    }
  }

  Future<void> makeAdmin(User user) async {
    user.roles.add("admin");
    final response = await post(
      '/users/${user.id}',
      user.toJson(),
    );
    if (response.status.hasError) {
      Get.snackbar("Error", response.statusText ?? "");
    } else {
      Get.snackbar("Success", "User made admin successfully");
    }
  }

  Future<void> deleteUser(String id) async {
    final user = users.firstWhere((user) => user.id == id);
    users.remove(user);
    final response = await delete('/users/$id');
    if (response.status.hasError) {
      Get.snackbar("Error", response.statusText ?? "");
    } else {
      Get.snackbar("Success", "User deleted successfully");
    }
  }

  Future<List<Score>?> getScoreByUserID(User user) async {
    final response = await get('/scores/user/${user.id}');
    if (response.status.hasError) {
      Get.snackbar("Error", response.statusText ?? "");
    } else {
      return (response.body as List).map((score) => Score.fromJson(score)).toList();
    }
  }

  Future<List<Score>?> getScoreByGameID(Game game) async {
    final response = await get('/scores/game/${game.id}');
    if (response.status.hasError) {
      Get.snackbar("Error", response.statusText ?? "");
    } else {
      return (response.body as List).map((score) => Score.fromJson(score)).toList();
    }
  }

  Future<List<Score>?> getScoreByUserIDAndGameID(Game game, User user) async {
    final response = await get('/scores/user/${user.id}/game/${game.id}');
    if (response.status.hasError) {
      Get.snackbar("Error", response.statusText ?? "");
    } else {
      return (response.body as List).map((score) => Score.fromJson(score)).toList();
    }
  }

  Future<void> addScore(CreateScoreRequest score) async {
    final response = await post('/scores', score.toJson());
    if (response.status.hasError) {
      Get.snackbar("Error", response.statusText ?? "");
    } else {
      Get.snackbar("Success", "Score added successfully");
    }
  }

  Future<void> createScore(String game, int score) async {
    final snakeID = "681f98923062f118b4d13f2a";
    final arkanoidID = "681f98923062f118b4d13f2b";
    final tetrisID = "681f98923062f118b4d13f2d";
    final raceID = "681f98923062f118b4d13f2c";
    String gameId = snakeID;
    switch (game) {
      case "Snake":
        gameId = snakeID;
        break;
      case "Arkanoid":
        gameId = arkanoidID;
        break;
      case "Tetris":
        gameId = tetrisID;
        break;
      case "Race":
        gameId = raceID;
        break;
    }
    final response = await post("/scores/", CreateScoreRequest(gameId: gameId, score: score).toJson());
    if (response.status.hasError) {
      Get.snackbar("Error", response.statusText ?? "");
    } else {
      Get.snackbar("Success", "Score added successfully");
    }
  }
}
