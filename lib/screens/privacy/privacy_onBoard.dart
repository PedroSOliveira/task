import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:task/config/custom_colors.dart';
import 'package:task/theme/manager_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../base/base_screen.dart';

@override
class PrivacyOnBoardScreen extends StatelessWidget {
  final themeModeManager = ThemeModeManager();

  void goToLoadAppOpenScreen(context) {
    final pageRoute = MaterialPageRoute(
        builder: (context) => BaseScreen(
              themeModeManager: themeModeManager,
            ));
    Navigator.of(context).pushReplacement(pageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        goToLoadAppOpenScreen(context);
        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Políticas de Privacidade',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    size: 30,
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    goToLoadAppOpenScreen(context);
                  },
                ),
                const Text('Políticas de Privacidade'),
                Image.asset(
                  'assets/logo.png', // Coloque o caminho da sua logo aqui
                  height: 30,
                ),
              ],
            ),
          ),
          body: WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(const Color(0x00000000))
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    // Update loading bar.
                  },
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) {},
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (NavigationRequest request) {
                    if (request.url.startsWith('https://www.youtube.com/')) {
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  },
                ),
              )
              ..loadRequest(
                Uri.parse('https://seven-software.web.app/privacy/task.html'),
              ),
          ),
        ),
      ),
    );
  }
}
