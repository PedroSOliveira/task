import 'package:task/ads/ads_ids.dart';
import 'package:task/ads/interstitial_ad_manager.dart';

class InterstitialWithMediation extends InterstitialAdManager {

  static InterstitialWithMediation? _instance;

  InterstitialWithMediation._() : super(AdsIds.interstitialAdId);

  static InterstitialAdManager get instance {
    _instance ??= InterstitialWithMediation._();
    return _instance!;
  }

}