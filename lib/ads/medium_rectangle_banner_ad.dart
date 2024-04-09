import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:task/ads/ads_ids.dart';

class MediumRectangleBannerAd extends StatefulWidget {

  const MediumRectangleBannerAd({super.key});

  @override
  State<MediumRectangleBannerAd> createState() => _MediumRectangleBannerAdState();
}

class _MediumRectangleBannerAdState extends State<MediumRectangleBannerAd> {

  late BannerAd banner;

  @override
  void initState() {    
    banner = BannerAd(
      adUnitId: AdsIds.mediumRectangleBannerAdId,
      request: const AdRequest(),
      size: AdSize.mediumRectangle,
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) => ad.dispose()
      )
    );

    super.initState();
  }

  Future<AdSize?> loadAd() async {
    await banner.load();
    return banner.getPlatformAdSize();
  }

  @override
  void dispose() {
    banner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    
    return FutureBuilder(
      future: loadAd(),
      builder: (context, snapshot) {
        final height = snapshot.data?.height ?? 0;
        final width = snapshot.data?.width ?? 0;

        if (height == 0 || width == 0) {
          return const SizedBox();
        }

        return SizedBox(
          width: AdSize.mediumRectangle.width.toDouble(),
          height: AdSize.mediumRectangle.height.toDouble(),
          child: Center(
            child: AdWidget(ad: banner)
          )
        );
      }
    );
  }

}