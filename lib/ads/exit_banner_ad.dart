import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:task/ads/ads_ids.dart';

class ExitBannerAd {

  BannerAd? banner;

  Future<AdSize?> loadAd() async {
    const emptyAdSize = AdSize(width: 0, height: 0);

    try {
      AdSize? adSize = AdSize.mediumRectangle;

      banner = BannerAd(
        adUnitId: AdsIds.mediumRectangleBannerAdId,
        request: const AdRequest(),
        size: adSize,
        listener: BannerAdListener(
          onAdFailedToLoad: (Ad ad, LoadAdError error) => ad.dispose()
        )
      );

      await banner?.load();

      final platformAdASize = await banner?.getPlatformAdSize();
      return platformAdASize;

    } catch(_) {
      return emptyAdSize;
    }
  }

  Widget show() {
    if (banner == null || banner?.size.width == 0 || banner?.size.height == 0) {
      return const SizedBox();
    }
    
    return SizedBox(
      width: AdSize.mediumRectangle.width.toDouble(),
      height: AdSize.mediumRectangle.height.toDouble(),
      child: Center(
        child: AdWidget(ad: banner!)
      )
    );
  }
}