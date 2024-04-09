import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task/ads/exit_banner_ad.dart';
import 'package:task/purchase/purchase_service.dart';

abstract class ExitBannerPopUp {

  static Future<bool> show(BuildContext context, ExitBannerAd exitBannerAd) async {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const containerWidth = 350;
    const containerHeight = 490;
    double horizontalPadding = 0.0;
    double verticalPadding = 0;

    if (screenHeight > containerHeight) {
      verticalPadding = ((screenHeight - containerHeight) / 2).truncateToDouble();
    }

    if (screenWidth > containerWidth) {
      horizontalPadding = ((screenWidth - containerWidth) / 2).truncateToDouble();
    }

    if (Platform.isIOS) {
      return true;
    }

    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop(true);
            return Future.value(true);
          },
          child: AlertDialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding
            ),
            content: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 if(PurchaseService.instance.userIsPro == false) exitBannerAd.show(),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Deseja realmente sair do aplicativo?",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton("Não",() => Navigator.of(context).pop(false), context),
                        _buildButton("Sim",() => Navigator.of(context).pop(true), context)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ) ?? false;
  }

  static Widget _buildButton(String title, VoidCallback onTap, BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.deepOrangeAccent)
          ),
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          )
        )
      ),
    );
  }
}