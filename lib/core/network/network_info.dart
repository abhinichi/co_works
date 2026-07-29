import 'package:connectivity_plus/connectivity_plus.dart';

/// Abstraction over connectivity checks so the domain/data layers can depend on
/// an interface rather than on the `connectivity_plus` package directly. This
/// keeps the implementation swappable and easy to fake in tests.
abstract interface class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this._connectivity);

  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return results.any((r) => r != ConnectivityResult.none);
  }
}
