import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task/models/user_model.dart';
import 'package:task/services/user_service.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  UserStorage user = new UserStorage(email: '', name: '', id: '', photo: '');

  void initialize() async {}

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    Future<UserStorage?> userAuthGoogle = UserService.getGoogleUser();
    // user = await userAuthGoogle; // Assuming user is set after fetching data

    final GoogleSignIn _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
   
    if (googleUser != null) {
      // Check if user is not null before accessing email
      if (user != null) {
        setState(() {
          user.email = googleUser.email;
          user.photo = googleUser.photoUrl.toString(); // Use null-safe setter (!)
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 245, 247),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user!.photo),
            ),
            const SizedBox(height: 10),

            Text(
              'Nome do Usuário',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.grey.shade800),
            ),

            // Email do usuário
            Text(
              'usuario@email.com',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.grey.shade800),
            ),

            const SizedBox(height: 20),

            // Itens de menu
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: ListView(
                  children: [
                    _MenuItem(
                      icon: Icons.privacy_tip,
                      title: 'Políticas de Privacidade',
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: Icons.description,
                      title: 'Termos de Uso',
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: Icons.menu,
                      title: 'Item de Menu 1',
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: Icons.menu,
                      title: 'Item de Menu 2',
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: Icons.menu,
                      title: 'Item de Menu 3',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: ListTile(
        tileColor: Colors.white,
        leading: Icon(
          icon,
          color: Colors.grey.shade400,
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}