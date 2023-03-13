import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:simple_chat/app/app.dart';

class GoogleBannerAd extends StatefulWidget {
  const GoogleBannerAd({super.key, this.adSize = AdSize.banner});

  final AdSize adSize;

  @override
  State<GoogleBannerAd> createState() => _GoogleBannerAdState();
}

class _GoogleBannerAdState extends State<GoogleBannerAd> {
  BannerAd? _ad;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _ad == null) return const SizedBox.shrink();
    return Center(
      child: SizedBox(
        width: widget.adSize.width.toDouble(),
        height: widget.adSize.height.toDouble(),
        child: AdWidget(ad: _ad!),
      ),
    );
  }

  void _load() {
    _ad = BannerAd(
      size: widget.adSize,
      adUnitId: GoogleAds.bannerId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    )..load();
  }
}
