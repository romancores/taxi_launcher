import 'package:taxi_launcher/src/models.dart';
import 'package:taxi_launcher/src/utils.dart';

/// Returns a url that is used by [showDirections]
String getRouteBuilderUrl({
  required TaxiAppType taxiAppType,
  required Coords destination,
  Coords? origin,
  Map<String, String>? extraParams,
}) {
  switch (taxiAppType) {
    case TaxiAppType.uber:
      return Utils.buildUrl(
        url: '',
        queryParams: {
          'action': 'setPickup',
          if (origin != null) 'pickup[latitude]': origin.latitude.toString(),
          if (origin != null) 'pickup[longitude]': origin.longitude.toString(),
          'dropoff[latitude]': destination.latitude.toString(),
          'dropoff[longitude]': destination.longitude.toString(),
          'product_id': 'UberX',
          ...(extraParams ?? {}),
        },
      );
    case TaxiAppType.cabify:
      return Utils.buildUrl(
        url: 'ride',
        queryParams: {
          // 'action': 'setPickup',
          if (origin != null) 'pickup': '${origin.latitude},${origin.longitude}',
          // if (origin != null) 'pickup[latitude]': origin.latitude.toString(),
          // if (origin != null) 'pickup[longitude]': origin.longitude.toString(),
          'dropoff': '${destination.latitude},${destination.longitude}',
          // 'dropoff[longitude]': destination.longitude.toString(),
          // 'product_id': 'Cabify',
          ...(extraParams ?? {}),
        },
      );
    case TaxiAppType.careem:
      return Utils.buildUrl(
        url: 'ride',
        queryParams: {
          // 'action': 'setPickup',
          if (origin != null) 'pickup': '${origin.latitude},${origin.longitude}',
          // if (origin != null) 'pickup[latitude]': origin.latitude.toString(),
          // if (origin != null) 'pickup[longitude]': origin.longitude.toString(),
          'dropoff': '${destination.latitude},${destination.longitude}',
          // 'dropoff[longitude]': destination.longitude.toString(),
          // 'product_id': 'Cabify',
          ...(extraParams ?? {}),
        },
      );
    case TaxiAppType.yango:
      return Utils.buildUrl(
        url: 'route',
        queryParams: {
          // 'action': 'setPickup'
          if (origin != null) 'start-lat': origin.latitude.toString(),
          if (origin != null) 'start-lon': origin.longitude.toString(),
          // 'dropoff': '${destination.latitude},${destination.longitude}',
          'end-lat': destination.latitude.toString(),
          'end-lon': destination.latitude.toString(),
          // 'product_id': 'Cabify',
          ...(extraParams ?? {}),
        },
      );
    case TaxiAppType.dtc:
      return Utils.buildUrl(
        url: 'route',
        queryParams: {
          // 'action': 'setPickup'
          if (origin != null) 'pickup[latitude]': origin.latitude.toString(),
          if (origin != null) 'pickup[longitude]': origin.longitude.toString(),
          // 'dropoff': '${destination.latitude},${destination.longitude}',
          'dropoff[latitude]': destination.latitude.toString(),
          'dropoff[longitude]': destination.longitude.toString(),
          // 'product_id': 'Cabify',
          ...(extraParams ?? {}),
        },
      );
    default:
      throw Exception('Unsupported taxi type: $taxiAppType');
  }
}
