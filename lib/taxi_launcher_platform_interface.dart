import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'taxi_launcher_method_channel.dart';

abstract class TaxiLauncherPlatform extends PlatformInterface {
  /// Constructs a TaxiLauncherPlatform.
  TaxiLauncherPlatform() : super(token: _token);

  static final Object _token = Object();

  static TaxiLauncherPlatform _instance = MethodChannelTaxiLauncher();

  /// The default instance of [TaxiLauncherPlatform] to use.
  ///
  /// Defaults to [MethodChannelTaxiLauncher].
  static TaxiLauncherPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TaxiLauncherPlatform] when
  /// they register themselves.
  static set instance(TaxiLauncherPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
