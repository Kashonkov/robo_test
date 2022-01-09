import 'package:dime_flutter/dime_flutter.dart';
import 'package:robo_test/core/network/net_client.dart';

class CoreDimeModule extends BaseDimeModule {
  @override
  void updateInjections() {
    addSingleByCreator((tag) => getClient());
  }
}