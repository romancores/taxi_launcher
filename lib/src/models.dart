import 'package:taxi_launcher/src/utils.dart';
import 'package:taxi_launcher/taxi_launcher.dart';

/// Defines the taxi app types supported by this plugin
enum TaxiAppType {
  /// Taxi app type Uber
  uber,

  /// Taxi app type Cabify
  cabify,

  /// Taxi app type Careem
  careem,

  /// Taxi app type Yango
  yango,

  /// Taxi app type DTC
  dtc,

  /// Taxi app type RideWithMe
  // rideWithMe,

  /// Taxi app type TaxiHail
  // taxiHail,

  /// Taxi app type Grab
  grab,
  /// Taxi app type InDrive
  inDrive,
  /// Taxi app type Gojek
  gojek,
  /// Taxi app type Bolt
  // bolt,
  /// Taxi app type YandexGo
  yandexgo,
}

/// Class that holds latitude and longitude coordinates
class Coords {
  final double latitude;
  final double longitude;

  Coords(this.latitude, this.longitude);
}

/// Class that holds all the information needed to launch a map
class AvailableTaxiApp {
  String taxiName;
  TaxiAppType taxiAppType;
  String icon;

  AvailableTaxiApp({
    required this.taxiName,
    required this.taxiAppType,
    required this.icon,
  });

  /// Parses json object to [AvailableMap]
  static AvailableTaxiApp? fromJson(json) {
    final TaxiAppType? taxiAppType = Utils.enumFromString(TaxiAppType.values, json['taxiAppType']);
    if (taxiAppType != null) {
      return AvailableTaxiApp(
        taxiName: json['taxiAppName'],
        taxiAppType: taxiAppType,
        icon: 'packages/taxi_launcher/assets/icons/${json['taxiAppType'].toLowerCase()}.svg',
      );
    } else {
      return null;
    }
  }

  factory AvailableTaxiApp.fromTaxiAppType(TaxiAppType taxiAppType) => AvailableTaxiApp(
      taxiName: Utils.capitalizedFirstLetter(Utils.enumToString(taxiAppType)) ?? '??',
      taxiAppType: taxiAppType,
      icon: 'packages/taxi_launcher/assets/icons/${Utils.enumToString(taxiAppType)?.toLowerCase()}.svg');

  /// Launches current map and shows directions to `destination`
  Future<void> launchTaxi({
    required Coords destination,
    Coords? origin,
    Map<String, String>? extraParams,
  }) {
    return TaxiLauncher.launchTaxi(
      taxiAppType: taxiAppType,
      destination: destination,
      origin: origin,
      extraParams: extraParams,
    );
  }

  @override
  String toString() {
    return 'AvailableTaxi { taxiAppName: $taxiName, taxiAppType: ${Utils.enumToString(taxiAppType)} }';
  }
}
