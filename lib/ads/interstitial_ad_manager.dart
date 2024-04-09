// import 'package:flutter/foundation.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// abstract class InterstitialAdManager {

//   late AdManagerInterstitialAd _interstitialAd;
//   static const int _maxAttemps = 15;
//   int _currentAttemp = 0;
//   String adId;

//   InterstitialAdManager(this.adId);

//   void load() {
//     try{
//       AdManagerInterstitialAd.load(
//         adUnitId: adId,
//         request: const AdManagerAdRequest(),
//         adLoadCallback: AdManagerInterstitialAdLoadCallback(
//           onAdLoaded: (AdManagerInterstitialAd ad) {
//             _interstitialAd = ad;
//             _currentAttemp = 0;
//             _setCallBack();
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             if(_currentAttemp >= _maxAttemps) return;
//             _currentAttemp++;
//             load();
//           },
//         ),
//         appEventListener: AppEventListener()
//       );
//     }catch(error) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     }
//   }

//   void _setCallBack() {
//     _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
//       onAdDismissedFullScreenContent: (AdManagerInterstitialAd ad) {
//         ad.dispose();
//       },
//       onAdFailedToShowFullScreenContent: (AdManagerInterstitialAd ad, AdError error) => ad.dispose(),
//     );
//   }

//   Future<void> show() async {
//     try {
//       await _interstitialAd.show().then((value) => load());
//       await Future.delayed(const Duration(milliseconds: 400));
//     } catch(error) {
//       if (kDebugMode) {
//         print(error);
//       }
//     }
//   }

// }