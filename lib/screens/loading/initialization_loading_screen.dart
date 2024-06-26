import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/ads/interstitial_with_mediation.dart';
import 'package:task/components/loading_screen.dart';
import 'package:task/firebase_options.dart';
import 'package:task/models/user_model.dart';
import 'package:task/screens/base/base_screen.dart';
import 'package:task/screens/login/login_screen.dart';
import 'package:task/services/user_service.dart';

import 'dart:io' show Platform;

import 'package:task/theme/manager_theme.dart';

class InitializationLoadingScreen extends StatefulWidget {
  const InitializationLoadingScreen({super.key});

  @override
  State<InitializationLoadingScreen> createState() =>
      _InitializationLoadingScreenState();
}

class _InitializationLoadingScreenState
    extends State<InitializationLoadingScreen> {
  final themeModeManager = ThemeModeManager();

  final String keyPreferencesFirstTime = "task@first_time";

  late UserService userService;

  UserStorage? user;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    initialize();
    super.didChangeDependencies();
  }

  void initialize() async {
    await Future.wait([
      MobileAds.instance.initialize(),
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
    ]);

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    // await PurchaseService.instance.initalize();

    await Future.wait([
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true),
      // OneSignal.shared.setAppId("980428f3-3aca-47bb-b4b5-5b4cd00ef2c9")
    ]);

    InterstitialWithMediation.instance.load();
    goToLoadAppOpenScreen();
  }

  bool getUser() {
    // Future<UserStorage?> userStorage = UserService.getGoogleUser();
    // Future<UserStorage?> userAuthGoogle = UserService.getGoogleUser();

    // // ignore: unnecessary_null_comparison
    // if (userStorage != null || userAuthGoogle != null) return true;

    return false;
  }

  void goToLoadAppOpenScreen() async {
    bool isFirstTime = await isFirstTimeUser();
    FirebaseAuth auth = FirebaseAuth.instance;

    bool user = getUser();

    if (auth.currentUser != null) {
      final pageRoute = MaterialPageRoute(
          builder: (context) => BaseScreen(
                themeModeManager: themeModeManager,
              ));
      markFirstTimeUser();
      Navigator.of(context).pushReplacement(pageRoute);
    } else {
      final pageRoute = MaterialPageRoute(builder: (context) => LoginScreen());

      Navigator.of(context).pushReplacement(pageRoute);
    }

    // MaterialPageRoute(builder: (context) => const LoadingScreen());
  }

  Future<bool> isFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool(keyPreferencesFirstTime) ?? true;
    return isFirstTime;
  }

  Future<void> markFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyPreferencesFirstTime, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white60),
          Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Center(child: CircularProgressIndicator())))
        ],
      ),
    );
  }
}
