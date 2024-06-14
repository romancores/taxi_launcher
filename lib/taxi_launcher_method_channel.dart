import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:taxi_launcher/src/models.dart';
import 'package:taxi_launcher/src/routes.dart';
import 'package:taxi_launcher/src/utils.dart';

import 'taxi_launcher_platform_interface.dart';

/// An implementation of [TaxiLauncherPlatform] that uses method channels.
class MethodChannelTaxiLauncher extends TaxiLauncherPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('taxi_launcher');

  @override
  Future<void> launchTaxi({
    required TaxiAppType taxiAppType,
    required Coords destination,
    Coords? origin,
    Map<String, String>? extraParams,
  }) async {
    final url = getRouteBuilderUrl(
      taxiAppType: taxiAppType,
      destination: destination,
      origin: origin,
      extraParams: extraParams,
    );
    await methodChannel.invokeMethod('launchTaxi', {
      'taxiAppType': Utils.enumToString(taxiAppType),
      'url': Uri.encodeFull(url),
    });
  }

  @override
  Future<List<AvailableTaxiApp>> getInstalledTaxis() async {
    final taxis = await methodChannel.invokeMethod('getInstalledTaxis');
    log('available taxis: $taxis',name: 'TaxiLauncher');
    return List<AvailableTaxiApp>.from(
      taxis.map((map) => AvailableTaxiApp.fromJson(map)),
    );
  }

  @override
  Future<bool?> isTaxiAppAvailable(TaxiAppType taxiAppType) async {
    final taxi = await methodChannel.invokeMethod(
      'isTaxiAppAvailable',
      {'taxiAppType': Utils.enumToString(taxiAppType)},
    );
    return taxi != null;
  }
}
