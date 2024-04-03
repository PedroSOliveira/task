import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:task/models/user_model.dart';
import 'package:task/screens/base/base_screen.dart';

import 'package:task/services/user_service.dart';
import 'package:task/theme/manager_theme.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final InAppReview inAppReview = InAppReview.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final String urlAndroid =
      'https://play.google.com/store/apps/details?id=com.seven.task';

  final String urlIos = 'https://apps.apple.com/app/id6474642833';

  void initialize() async {}

  @override
  void initState() {
    super.initState();
  }

  void homeBack(BuildContext context) {
    final themeModeManager = ThemeModeManager();

    try {
      bool showBanner = false;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => BaseScreen(
                    themeModeManager: themeModeManager,
                  )),
          (_) => false);
    } catch (e) {
      print(e);
    }
  }

  void requestShareApp(BuildContext context) async {
    try {
      String url = Platform.isIOS ? urlIos : urlAndroid;

      Share.share('Organize sua rotina e baixe agora: \n $url');
    } catch (err) {
      print(err);
    }
  }

  void _requestAppRating(BuildContext context) async {
    try {
      if (await inAppReview.isAvailable()) {
        inAppReview.requestReview();
      } else {
        inAppReview.openStoreListing(appStoreId: 'com.seven.task');
      }
    } catch (err) {
      print(err);
    }
  }

  void requestNotificationPermission(BuildContext context) async {
    try {
      await OneSignal.Notifications.requestPermission(false);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.grey,
            size: 30,
          ),
          onPressed: () {
            homeBack(context);
          },
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(auth.currentUser!.photoURL!),
            ),
            const SizedBox(height: 10),
            Text(
              auth.currentUser!.displayName!,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.grey.shade800),
            ),
            Text(
              auth.currentUser!.email!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.grey.shade800),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  // borderRadius: const BorderRadius.only(
                  //   bottomLeft: Radius.circular(16.0),
                  //   bottomRight: Radius.circular(0.0),
                  // ),
                ),
                child: ListView(
                  children: [
                    _MenuItem(
                      icon: Icons.privacy_tip,
                      title: 'Políticas de Privacidade',
                      onTap: () {
                        Navigator.pushNamed(context, '/privacy');
                      },
                    ),
                    _MenuItem(
                      icon: Icons.description,
                      title: 'Termos de Uso',
                      onTap: () {
                        Navigator.pushNamed(context, '/terms');
                      },
                    ),
                    _MenuItem(
                      icon: Icons.notifications_on,
                      title: 'Notificações',
                      onTap: () => requestNotificationPermission(context),
                    ),
                    _MenuItem(
                      icon: Icons.share_rounded,
                      title: 'Compartilhar app',
                      onTap: () => requestShareApp(context),
                    ),
                    _MenuItem(
                      icon: Icons.star,
                      title: 'Avaliar app',
                      onTap: () => _requestAppRating(context),
                    ),
                    _MenuItem(
                      icon: Icons.logout,
                      title: 'Logout',
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
