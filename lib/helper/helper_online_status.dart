import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class HelperOnlineStatus extends ChangeNotifier {
  Connectivity connectivity;

  HelperOnlineStatus(this.connectivity);

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];

  List<ConnectivityResult> get connectionStatus => _connectionStatus;

  Future<void> initConnectivity() async {
    try {
      await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }
  }

  Future<void> subscribeConnectivity() async {
    _connectivitySubscription = connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus = result;
    notifyListeners();
  }

  void cancelConnectivitySubscription() {
    _connectivitySubscription.cancel();
  }
}
