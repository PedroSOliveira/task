import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:task/ads/ads_ids.dart';

class AppOpenAdManager {

  static AppOpenAdManager? _appOpenAdManager;

  AppOpenAdManager._();

  static AppOpenAdManager get instance => _appOpenAdManager ??= AppOpenAdManager._();

  static AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  final _maxAttemps = 5;
  int _currentAttemp = 0;
  final _adLoadedStreamController = StreamController<bool>();
  final _onAdShowedCallbacks = <Function>[];
  final _onAdFailedToShowCallbacks = <Function>[];
  final _onAdCloseCallbacks = <Function>[];
  bool _showedAd = false;

  bool get showedAd => _showedAd;
  Stream<bool> get adLoadedStream => _adLoadedStreamController.stream;
  bool get isShowingAd => _isShowingAd;

  void loadAd() {
    AppOpenAd.load(
      adUnitId: AdsIds.appOpenAdId,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
           _appOpenAd = ad;
           _adLoadedStreamController.sink.add(true);
        },
        onAdFailedToLoad: (error) {
          if(_currentAttemp >= _maxAttemps) return;
          _currentAttemp++;
          loadAd();
        },
      ),
    );
  }

  Future<void> showAdIfAvailable() async{
    if (adIsAvailable == false) {
      loadAd();
      return;
    }

    if (_isShowingAd) return;
    
    _appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _showedAd = true;
        _isShowingAd = true;
        _notifyAdShowedCallbacks();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        _notifyAdFailedToShowCallbacks();
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
        _notifyAdCloseCallbacks();
      },
    );
    
    await _appOpenAd?.show();
  }

  void addOnAdCloseCallback(Function function) => _onAdCloseCallbacks.add(function);
  
  void addOnAdShowedCallback(Function function) => _onAdShowedCallbacks.add(function);

  void addOnAdFailedToShowCallback(Function function) => _onAdFailedToShowCallbacks.add(function);
  
  // ignore: avoid_function_literals_in_foreach_calls
  void _notifyAdFailedToShowCallbacks() => _onAdFailedToShowCallbacks.forEach((function) => function());

  // ignore: avoid_function_literals_in_foreach_calls
  void _notifyAdShowedCallbacks() => _onAdShowedCallbacks.forEach((function) => function());

  // ignore: avoid_function_literals_in_foreach_calls
  void _notifyAdCloseCallbacks() => _onAdCloseCallbacks.forEach((function) => function());

  bool get adIsAvailable => _appOpenAd != null;

  void dispose() => _adLoadedStreamController.close();

}