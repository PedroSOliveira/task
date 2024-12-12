import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._internal();
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  factory RemoteConfigService() {
    return _instance;
  }

  RemoteConfigService._internal();

  Future<void> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 0),
      ));
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      print("Erro ao inicializar Remote Config: $e");
    }
  }

  bool get isShowAnnouncement {
    return _remoteConfig.getBool('isShowAnnouncement');
  }
}
