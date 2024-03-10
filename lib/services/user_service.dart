import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/models/user_model.dart';

class UserService {
  static const String _keyUser = 'task@user';

  // Método para salvar o usuário logado no SharedPreferences
  static Future<void> saveUserShared(UserStorage user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString(_keyUser, userJson);
  }

  // Método para retornar o usuário salvo no SharedPreferences
  static Future<UserStorage?> getUserShared() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_keyUser);
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return UserStorage.fromJson(userMap);
    }
    return null;
  }

  // Método para retornar o usuário autenticado pelo Google
  static Future<UserStorage?> getGoogleUser() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        return UserStorage(
          id: googleUser.id,
          name: googleUser.displayName ?? '',
          email: googleUser.email,
          photo: googleUser.photoUrl ?? '',
        );
      }
    } catch (error) {
      print('Erro ao autenticar com o Google: $error');
    }
    return null;
  }
}
