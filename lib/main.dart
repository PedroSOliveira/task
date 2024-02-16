import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:task/routes/app_routes.dart';
import 'package:task/screens/base/base_screen.dart';
import 'package:task/theme/manager_theme.dart';

void main() {
  final themeModeManager = ThemeModeManager();

  runApp(
    ProviderScope(
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BaseScreen(themeModeManager: themeModeManager),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [const Locale('pt', 'BR')],
        getPages: AppRoutes.pages,
      ),
    ),
  );
}
