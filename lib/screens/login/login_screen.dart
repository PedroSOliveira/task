import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task/controller/google_auth_controller.dart';
import 'package:task/firebase_options.dart';
import 'package:task/models/user_model.dart';
import 'package:task/screens/base/base_screen.dart';
import 'package:task/services/user_service.dart';
import 'package:task/theme/manager_theme.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final themeModeManager = ThemeModeManager();

  User? _user;

  @override
  void initState() {
    // TODO: implement initState
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
    super.initState();
  }

  void _handleGoogleSignin(context) async {
    try {
      await GoogleAuthController().signInWithGoogle();
      // Faça login com o Google
      // UserCredential userCredential =
      //     await GoogleAuthController().signInWithGoogle();

      // if (userCredential.user != null) {
      //   print(
      //       'Usuário autenticado com sucesso: ${userCredential.user!.displayName}');

      //   final pageRoute = MaterialPageRoute(
      //       builder: (context) => BaseScreen(
      //             themeModeManager: themeModeManager,
      //           ));
      //   Navigator.of(context).pushReplacement(pageRoute);
      // } else {
      //   print('Erro: Usuário nulo após o login.');
      // }
      final pageRoute = MaterialPageRoute(
          builder: (context) => BaseScreen(
                themeModeManager: themeModeManager,
              ));
      Navigator.of(context).pushReplacement(pageRoute);
      // GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      // _auth.signInWithProvider(_googleAuthProvider);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Bem-vindo(a)',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    'Gerencie sua rotina e organize suas atividades diárias.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              _handleGoogleSignin(context);
              // Implemente a lógica de login com o Google aqui
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              child: Text(
                'Entrar com o Google',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade400,
              // primary: Colors.blue,
              // onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
