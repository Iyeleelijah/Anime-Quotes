import 'package:flutter/foundation.dart';

class AdHelper {
  // Use TEST IDs while developing. Replace with your real unit IDs before release.
  static String get bannerAdUnitId {
    if (kReleaseMode) {
      //put your REAL Banner Unit ID here
      return 'ca-app-pub-8926074249456703/3108080227';
    }
    // Test banner
    return 'ca-app-pub-3940256099942544/6300978111';
  }

  static String get interstitialAdUnitId {
    if (kReleaseMode) {
      
      //put your REAL Interstitial Unit ID here
      return 'ca-app-pub-8926074249456703/9920707063';
    }

    // Test interstitial
    return 'ca-app-pub-3940256099942544/1033173712';
  }
}
