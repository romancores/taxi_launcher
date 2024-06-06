import 'package:flutter_test/flutter_test.dart';
import 'package:taxi_launcher/taxi_launcher.dart';
import 'package:taxi_launcher/taxi_launcher_platform_interface.dart';
import 'package:taxi_launcher/taxi_launcher_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTaxiLauncherPlatform
    with MockPlatformInterfaceMixin
    implements TaxiLauncherPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TaxiLauncherPlatform initialPlatform = TaxiLauncherPlatform.instance;

  test('$MethodChannelTaxiLauncher is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTaxiLauncher>());
  });

  test('getPlatformVersion', () async {
    TaxiLauncher taxiLauncherPlugin = TaxiLauncher();
    MockTaxiLauncherPlatform fakePlatform = MockTaxiLauncherPlatform();
    TaxiLauncherPlatform.instance = fakePlatform;

    expect(await taxiLauncherPlugin.getPlatformVersion(), '42');
  });
}
