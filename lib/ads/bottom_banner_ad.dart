import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:task/ads/ads_ids.dart';

class BottomBannerAd extends StatefulWidget {

  final AdSize? adSize;

  const BottomBannerAd({super.key, this.adSize});

  @override
  State<BottomBannerAd> createState() => _BottomBannerAdState();
}

class _BottomBannerAdState extends State<BottomBannerAd> {

  BannerAd? banner;

  Future<AdSize?> loadAd() async {
    const emptyAdSize = AdSize(width: 0, height: 0);

    try {
      final screenWidth = MediaQuery.of(context).size.width;
      AdSize? adSize;
      if (widget.adSize == null) {
        adSize = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(screenWidth.toInt());
      } else {
        adSize = widget.adSize;
      }

      adSize ??= AdSize.banner;

      banner = BannerAd(
        adUnitId: AdsIds.bottomBannerAdId,
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

  @override
  void dispose() {
    banner?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadAd(),
      builder: (context, AsyncSnapshot<AdSize?> snapshot) {
        final height = snapshot.data?.height ?? 0;
        final width = snapshot.data?.width ?? 0;
        if (height != 0 && width != 0 && banner != null) {
          return SafeArea(
            child: SizedBox(
              width: width.toDouble(),
              height: height.toDouble(),
              child: Center(
                child: AdWidget(ad: banner!)
              )
            ),
          );
        }

        return const SizedBox();
      }
    );
  }

}