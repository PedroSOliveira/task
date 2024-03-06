import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:task/components/show_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task/screens/base/base_screen.dart';
import 'package:task/theme/manager_theme.dart';
import 'package:task/widget/card_todo_widget.dart';

void main() {
  final themeModeManager = ThemeModeManager();

  runApp(
    ProviderScope(
      child: MaterialApp(
        locale: const Locale('pt', 'BR'),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BaseScreen(
          themeModeManager: themeModeManager,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [Locale('pt', 'BR')],
      ),
    ),
  );
}
