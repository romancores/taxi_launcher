import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'taxi_launcher_platform_interface.dart';

/// An implementation of [TaxiLauncherPlatform] that uses method channels.
class MethodChannelTaxiLauncher extends TaxiLauncherPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('taxi_launcher');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
