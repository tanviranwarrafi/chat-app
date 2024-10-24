import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LifecycleObserver with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // App is in the foreground
        // if (!_isForeground) _setOnlineOfflineStatus(status: true);
        // _isForeground = true;
        // _isBackground = false;
        if (kDebugMode) print('App resumed');
        break;
      case AppLifecycleState.paused:
        // App is in the background
        // if (!_isBackground) _setOnlineOfflineStatus(status: false);
        // _isBackground = true;
        // _isForeground = false;
        if (kDebugMode) print('App paused');
        break;
      case AppLifecycleState.inactive:
        // App is in an inactive state (possibly transitioning between foreground & background)
        if (kDebugMode) print('App inactive');
        break;
      case AppLifecycleState.detached:
        // App is terminated
        // _setOnlineOfflineStatus(status: false);
        // _isBackground = false;
        // _isForeground = false;
        if (kDebugMode) print('App terminated');
        break;
      case AppLifecycleState.hidden:
        if (kDebugMode) print('App hidden');
        break;
    }
  }

  /*Future<void> _setOnlineOfflineStatus({required bool status}) async {
    var authStatus = sl<AuthService>().authStatus;
    var token = sl<StorageService>().bearerToken;
    if (!authStatus || token.isEmpty) return;
    unawaited(sl<ChatRepository>().setOnlineStatus(status: true));
  }*/
}
