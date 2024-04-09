// import 'package:flutter/material.dart';
// import 'package:task/ads/app_open_ad_manager.dart';
// import 'package:task/ads/interstitial_with_mediation.dart';
// import 'package:task/screens/base/base_screen.dart';
// import 'package:task/theme/manager_theme.dart';

// class LoadingScreen extends StatefulWidget {
  
//   const LoadingScreen({super.key});

//   @override
//   State<LoadingScreen> createState() => _LoadingScreenState();
// }

// class _LoadingScreenState extends State<LoadingScreen> {

//   int maxLoadingTimeInSeconds = 4;
//   AppOpenAdManager? appOpenAdManager;
//   bool semaphoreIsOpen = true;
//   final themeModeManager = ThemeModeManager();

//   @override
//   void initState() {
//     initialize();
//     super.initState();
//   }

//   void initialize() async {

//     appOpenAdManager = AppOpenAdManager.instance
//       ..addOnAdShowedCallback(goToHomeScreen)
//       ..addOnAdFailedToShowCallback(onAdFail)
//       ..loadAd();

//     Future.delayed(
//       Duration(seconds: maxLoadingTimeInSeconds),
//       () {
//         if(appOpenAdManager!.adIsAvailable == false && semaphoreIsOpen) {
//           onAdFail();
//         }
//       }
//     );

//     appOpenAdManager!.adLoadedStream.listen((loaded) async {
//       if(loaded && semaphoreIsOpen) {
//         semaphoreIsOpen = false;
//         await appOpenAdManager!.showAdIfAvailable();
//       }
//     });
//   }

//   void onAdFail() {
//     semaphoreIsOpen = false;
//     goToHomeScreen(delay: false);
//   }

//   void goToHomeScreen({bool delay = true}) {
//     InterstitialWithMediation.instance.load();
//     PageRoute pageRoute;

//     if(delay) {
//       pageRoute = PageRouteBuilder(
//         pageBuilder: (context, animation1, animation2) => BaseScreen(themeModeManager: themeModeManager),
//         transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
//         transitionDuration: const Duration(milliseconds: 1500),
//       );
//     } else {
//       pageRoute = MaterialPageRoute(builder: (context) => BaseScreen(themeModeManager: themeModeManager));
//     }
//     Navigator.of(context).pushReplacement(pageRoute);
//   }

//   @override
//   void dispose() {
//     appOpenAdManager?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             color: themeModeManager.themeMode == ThemeMode.dark ? Colors.black54 : Colors.white60
//           ),
//           const Center(
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)
//             )
//           )
//         ],
//       ),
//     );
//   }

// }
