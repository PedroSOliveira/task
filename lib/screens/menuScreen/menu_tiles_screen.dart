import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:task/models/user_model.dart';
import 'package:task/screens/base/base_screen.dart';
import 'package:task/screens/login/login_screen.dart';

import 'package:task/services/user_service.dart';
import 'package:task/theme/manager_theme.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final InAppReview inAppReview = InAppReview.instance;
  // FirebaseAuth auth = FirebaseAuth.instance;

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

  void _handleSignOut(BuildContext context) async {
    // await auth.signOut();
    final pageRoute = MaterialPageRoute(builder: (context) => LoginScreen());

    Navigator.of(context).pushReplacement(pageRoute);
  }

  Color get backgroundColor => ThemeModeManager.isDark
      ? Colors.grey.shade900
      : const Color.fromARGB(255, 255, 255, 255);

  Color get contentColor =>
      ThemeModeManager.isDark ? Colors.grey.shade800 : Colors.white;

  Color get textColor =>
      ThemeModeManager.isDark ? Colors.grey.shade500 : Colors.black;

  Color get textInfoAccountColor =>
      ThemeModeManager.isDark ? Colors.grey.shade500 : Colors.grey.shade800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'Menu',
          style: TextStyle(color: textColor, fontSize: 20),
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
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
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

  Color get contentColor =>
      ThemeModeManager.isDark ? Colors.grey.shade800 : Colors.white;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: ListTile(
        tileColor: contentColor,
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
