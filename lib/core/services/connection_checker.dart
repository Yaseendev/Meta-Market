import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

abstract class ConnectionChecker {
  Future<bool> get isConnected;
}

@LazySingleton(as: ConnectionChecker)
class ConnectionCheckerConnectivity implements ConnectionChecker {
  final Connectivity _connectivity;

  ConnectionCheckerConnectivity([Connectivity? connectivityInstance])
      : _connectivity = connectivityInstance ?? Connectivity();

  @override
  Future<bool> get isConnected async =>
      await _connectivity.checkConnectivity() != ConnectivityResult.none;
}
