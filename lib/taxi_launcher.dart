
import 'taxi_launcher_platform_interface.dart';

class TaxiLauncher {
  Future<String?> getPlatformVersion() {
    return TaxiLauncherPlatform.instance.getPlatformVersion();
  }
}
