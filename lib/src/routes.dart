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
          'action': 'setPickup',
          // if (origin != null) 'pickup': '${origin.latitude},${origin.longitude}',
          if (origin != null) 'pickup[latitude]': origin.latitude.toString(),
          if (origin != null) 'pickup[longitude]': origin.longitude.toString(),
          // 'dropoff': '${destination.latitude},${destination.longitude}',
          'dropoff[latitude]': destination.latitude.toString(),
          'dropoff[longitude]': destination.longitude.toString(),
          'product_id': 'Rides',
          ...(extraParams ?? {}),
        },
      );
    case TaxiAppType.yango:
      return Utils.buildUrl(
        url: '',
        queryParams: {
          // 'action': 'setPickup'
          if (origin != null) 'gfrom':'${origin.latitude},${origin.longitude}',
          'gto':'${destination.latitude},${destination.longitude}',
          // 'ref'
          // if (origin != null) 'start-lat': origin.latitude.toString(),
          // if (origin != null) 'start-lon': origin.longitude.toString(),
          // 'dropoff': '${destination.latitude},${destination.longitude}',
          // 'end-lat': destination.latitude.toString(),
          // 'end-lon': destination.latitude.toString(),
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
    case TaxiAppType.yandexgo:
      return Utils.buildUrl(
        url: 'route',
        queryParams: {
          'data-app': '3',
          if (origin != null) 'start-lat': origin.latitude.toString(),
          if (origin != null) 'start-lon': origin.longitude.toString(),
          // 'dropoff': '${destination.latitude},${destination.longitude}',
          'end-lat': destination.latitude.toString(),
          'end-lon': destination.latitude.toString(),
          'data-redirect': '25395763362139037',
          ...(extraParams ?? {}),
        },
      );
    case TaxiAppType.grab:
      return Utils.buildUrl(
        url: '',
        queryParams: {
          'action': 'pickup',
          if (origin != null) 'pickupLat': origin.latitude.toString(),
          if (origin != null) 'pickupLong': origin.longitude.toString(),
          // 'dropoff': '${destination.latitude},${destination.longitude}',
          'dropoffLat': destination.latitude.toString(),
          'dropoffLong': destination.longitude.toString(),
          // 'product_id': 'Grab',
          ...(extraParams ?? {}),
        }
      );
      case TaxiAppType.gojek:
        return Utils.buildUrl(
          url: '',
          queryParams: {
            'action': 'pickUp',
            if (origin != null) 'latitude': origin.latitude.toString(),
            if (origin != null) 'longitude': origin.longitude.toString(),
            // 'dropoff': '${destination.latitude},${destination.longitude}',
            'dropoffLatitude': destination.latitude.toString(),
            'dropoffLongitude': destination.longitude.toString(),
            // 'product_id': 'Gojek',
           ...(extraParams?? {}),
          }
        );
        case TaxiAppType.inDrive:
          return Utils.buildUrl(
            url: '',
            queryParams: {
              // 'action': 'findARide',
              if (origin != null) 'pickupLat': origin.latitude.toString(),
              if (origin != null) 'pickupLong': origin.longitude.toString(),
              // 'dropoff': '${destination.latitude},${destination.longitude}',
              'dropoffLat': destination.latitude.toString(),
              'dropoffLong': destination.longitude.toString(),
              // 'product': 'indrive',
             ...(extraParams?? {}),
            }
          );
    default:
      throw Exception('Unsupported taxi type: $taxiAppType');
  }
}
