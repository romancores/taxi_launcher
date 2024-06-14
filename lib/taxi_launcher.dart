import 'package:taxi_launcher/src/models.dart';

import 'taxi_launcher_platform_interface.dart';

class TaxiLauncher {
  static Future<void> launchTaxi({
    required TaxiAppType taxiAppType,
    required Coords destination,
    Coords? origin,
    Map<String, String>? extraParams,
  }) {
    return TaxiLauncherPlatform.instance.launchTaxi(
      taxiAppType: taxiAppType,
      destination: destination,
      origin: origin,
      extraParams: extraParams,
    );
  }

  /// Returns list of installed map apps on the device.
  static Future<List<AvailableTaxiApp>> get installedTaxis async {
    return TaxiLauncherPlatform.instance.getInstalledTaxis();
  }

  /// Returns boolean indicating if map app is installed
  static Future<bool?> isTaxiAppAvailable(TaxiAppType taxiAppType) async {
    return TaxiLauncherPlatform.instance.isTaxiAppAvailable(taxiAppType);
  }

  static AvailableTaxiApp getTaxiApp(TaxiAppType taxiAppType) => AvailableTaxiApp.fromTaxiAppType(taxiAppType);
}
