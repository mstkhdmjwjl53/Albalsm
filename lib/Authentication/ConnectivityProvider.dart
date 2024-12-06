import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityProvider with ChangeNotifier {
  bool _isConnected = true;

  ConnectivityProvider() {
    _checkConnection();
    InternetConnectionChecker().onStatusChange.listen((status) {
      _isConnected = status == InternetConnectionStatus.connected;
      notifyListeners();
    });
  }

  bool get isConnected => _isConnected;

  Future<void> _checkConnection() async {
    _isConnected = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }
}
