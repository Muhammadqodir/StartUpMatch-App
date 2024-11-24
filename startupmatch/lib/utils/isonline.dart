import 'package:connectivity_plus/connectivity_plus.dart';

class Isonline {
  Future<bool> isOnline() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
