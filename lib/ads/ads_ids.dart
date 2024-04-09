import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class AdsIds {
  static const _testBanner = "ca-app-pub-3940256099942544/6300978111";
  static const _testInterstitial = "ca-app-pub-3940256099942544/1033173712";
  static const _testAppOpen = "ca-app-pub-3855206224550598/8356856806";

  static const _androidBanner = "ca-app-pub-1837125269900681/3277879031";
  static const _iosBanner = "ca-app-pub-1837125269900681/3254738743";

  static get bottomBannerAdId {
    if (kDebugMode) {
      return _testBanner;
    }

    return Platform.isAndroid ? _androidBanner : _iosBanner;
  }

  static const _androidMediumRetangleBanner =
      "ca-app-pub-1837125269900681/9310888626";
  static const _iosMediumRetangleBanner =
      "ca-app-pub-1837125269900681/4513385068";

  static get mediumRectangleBannerAdId {
    if (kDebugMode) {
      return _testBanner;
    }

    return Platform.isAndroid
        ? _androidMediumRetangleBanner
        : _iosMediumRetangleBanner;
  }

  static const _iosInterstitial = "ca-app-pub-1837125269900681/5880902080";
  static const _androidInterstitialWithMediation =
      "ca-app-pub-1837125269900681/4142322424";
  static const _androidInterstitialWithoutMediation =
      "ca-app-pub-1837125269900681/4646105837";
  static get interstitialAdId =>
      Platform.isAndroid ? _androidInterstitialWithMediation : _iosInterstitial;

  static get interstitialWithoutMediation {
    if (kDebugMode) {
      return _testInterstitial;
    }

    return Platform.isAndroid
        ? _androidInterstitialWithoutMediation
        : _iosInterstitial;
  }

  static const _androidOpenApp = "ca-app-pub-1837125269900681/6684725287";
  static const _iosOpenApp = "ca-app-pub-1837125269900681/1300943841";

  static get appOpenAdId {
    if (kDebugMode) {
      return _testAppOpen;
    }

    return Platform.isAndroid ? _androidOpenApp : _iosOpenApp;
  }
}
