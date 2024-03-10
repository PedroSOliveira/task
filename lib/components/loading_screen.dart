import 'package:flutter/material.dart';

import 'package:task/screens/base/base_screen.dart';
import 'package:task/theme/manager_theme.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int maxLoadingTimeInSeconds = 4;
  // AppOpenAdManager? appOpenAdManager;
  bool semaphoreIsOpen = true;
  final themeModeManager = ThemeModeManager();

  @override
  void initState() {
    super.initState();
  }

  void onAdFail() {
    semaphoreIsOpen = false;
    goToHomeScreen(delay: false);
  }

  void goToHomeScreen({bool delay = true}) {
    // InterstitialWithMediation.instance.load();
    PageRoute pageRoute;

    if (delay) {
      pageRoute = PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            BaseScreen(themeModeManager: themeModeManager),
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 1500),
      );
    } else {
      pageRoute = MaterialPageRoute(
          builder: (context) => BaseScreen(themeModeManager: themeModeManager));
    }
    Navigator.of(context).pushReplacement(pageRoute);
  }

  @override
  void dispose() {
    // appOpenAdManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: themeModeManager.themeMode == ThemeMode.dark
                    ? Colors.black54
                    : Colors.white60),
            Center(
                child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 100),
                const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
