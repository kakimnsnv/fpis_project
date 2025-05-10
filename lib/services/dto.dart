class RegisterDTO {
  String username;
  String password;
  String email;

  RegisterDTO({required this.username, required this.password, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
    };
  }
}

class LoginDTO {
  String username;
  String password;

  LoginDTO({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class Game {
  String id;
  String name;
  String sound;

  Game({required this.id, required this.name, required this.sound});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sound': sound,
    };
  }

  Game.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        sound = json['sound'];
}

class User {
  String id;
  String username;
  String email;
  List<String> roles;

  User({required this.id, required this.username, required this.email, required this.roles});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        roles = List<String>.from(json['roles']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'roles': roles,
    };
  }
}

class Score {
  final String id;
  final String gameName;
  final String userName;
  final int score;

  Score({required this.id, required this.gameName, required this.userName, required this.score});

  Score.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        gameName = json['gameName'],
        userName = json['userName'],
        score = json['score'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gameName': gameName,
      'userName': userName,
      'score': score,
    };
  }
}

class CreateScoreRequest {
  final String gameId;
  final int score;

  CreateScoreRequest({required this.gameId, required this.score});
  Map<String, dynamic> toJson() {
    return {
      'gameId': gameId,
      'score': score,
    };
  }
}
