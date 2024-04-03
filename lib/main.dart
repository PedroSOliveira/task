import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task/screens/loading/initialization_loading_screen.dart';
import 'package:task/screens/privacy/privacy.dart';
import 'package:task/screens/terms/terms.dart';
import 'package:task/theme/manager_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeModeManager themeModeManager = ThemeModeManager();

  late ThemeMode themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    themeModeManager.onThemeChange.listen((newTheme) {
      setState(() => themeMode = newTheme);
    });

    // InterstitialWithMediation.instance.load();

    themeMode = themeModeManager.themeMode;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        locale: const Locale('pt', 'BR'),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const InitializationLoadingScreen(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        routes: {
        '/terms': (context) => TermsScreen(),
        '/privacy': (context) => PrivacyScreen(),
      },
      ),
    );
  }
}
