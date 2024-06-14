import 'package:flutter_test/flutter_test.dart';
import 'package:taxi_launcher/taxi_launcher.dart';
import 'package:taxi_launcher/taxi_launcher_platform_interface.dart';
import 'package:taxi_launcher/taxi_launcher_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';


void main() {
  final TaxiLauncherPlatform initialPlatform = TaxiLauncherPlatform.instance;

  test('$MethodChannelTaxiLauncher is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTaxiLauncher>());
  });

}
