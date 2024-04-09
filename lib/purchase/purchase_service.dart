import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseService {
  late CustomerInfo _purchaserInfo;
  Offerings? _offerings;

  static const androidSdkKey = "goog_dIHLQwDdwArKeytsiEfSWusxoJb";
  static const iosSdkKey = "appl_liriFQsbugAaedZIJLiWgAyUdSq";
  static const entitlement = "simulado_enem";

  PurchaseService._();

  static PurchaseService? _instance;

  static PurchaseService get instance => _instance ??= PurchaseService._();

  Future<void> initalize() async {
    try {
      if (kDebugMode) {
        await Purchases.setLogLevel(LogLevel.debug);
      }

      final configuration = PurchasesConfiguration(
          Platform.isAndroid ? androidSdkKey : iosSdkKey);
      await Purchases.configure(configuration);

      _purchaserInfo = await Purchases.getCustomerInfo();

      if (userIsPro == false) {
        _offerings = await Purchases.getOfferings();
      }

      //subscripeTheApp();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<bool> restoreTransactions() async {
    try {
      _purchaserInfo = await Purchases.restorePurchases();
      return userIsPro;
    } catch(_) {
      return false;
    }
  }
  
  Future<bool> subscripeTheApp() async {
    try {
      _offerings ??= await Purchases.getOfferings();

      final package = _offerings?.current?.lifetime;
      if (package == null) throw Exception("Product is null");

    
      _purchaserInfo = await Purchases.purchasePackage(package);

      return userIsPro;
    } catch (error) {
      return false;
    }
  }

  String getPrice() {
    if (kReleaseMode) {
      return _offerings?.current?.lifetime?.storeProduct.priceString ?? "";
    }

    return "R\$ 19,99";
  }

  bool get userIsPro {
    try {
      return _purchaserInfo.entitlements.all[entitlement]?.isActive ?? false;
    } catch (_) {
      return false;
    }
  }
}
