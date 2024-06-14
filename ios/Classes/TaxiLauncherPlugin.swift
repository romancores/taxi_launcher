import Flutter
import UIKit


private enum TaxiAppType: String {
    case uber
    case cabify
    case yango
    case careem
    case dtc
    case shail

    func type() -> String {
        return self.rawValue
    }
}

private class Taxi {
    let taxiAppName: String;
    let taxiAppType: TaxiAppType;
    let urlPrefix: String;


    init(taxiAppName: String, taxiAppType: TaxiAppType, urlPrefix: String) {
        self.taxiAppName = taxiAppName
        self.taxiAppType = taxiAppType
        self.urlPrefix = urlPrefix
    }

    func toMap() -> [String:String] {
        return [
            "taxiAppName": taxiAppName,
            "taxiAppType": taxiAppType.type(),
        ]
    }
}

private let taxis: [Taxi] = [
    Taxi(taxiAppName: "Uber", taxiAppType: TaxiAppType.uber, urlPrefix: "uber://"),
    Taxi(taxiAppName: "Careem", taxiAppType: TaxiAppType.careem, urlPrefix: "careem://"),
    Taxi(taxiAppName: "Cabify", taxiAppType: TaxiAppType.cabify,urlPrefix: "cabify://"),
    Taxi(taxiAppName: "DTC", taxiAppType: TaxiAppType.dtc,urlPrefix: "dtc://"),
    Taxi(taxiAppName: "Yango", taxiAppType: TaxiAppType.dtc,urlPrefix: "yango://"),
    Taxi(taxiAppName: "Shail", taxiAppType: TaxiAppType.shail,urlPrefix: "shail://")
]

private func getTaxiByRawTaxiAppType(type: String) -> Taxi? {
    return taxis.first(where: { $0.taxiAppType.type() == type })
}


private func showDirections(taxiType: TaxiAppType, url: String) {

        UIApplication.shared.open(URL(string:url)!, options: [:], completionHandler: nil)
}


private func isTaxiAppAvailable(taxi: Taxi?) -> Bool {
    // taxitype is not available on iOS
    guard let taxi = taxi else {
        return false
    }
    return UIApplication.shared.canOpenURL(URL(string:taxi.urlPrefix)!)
}


public class TaxiLauncherPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "taxi_launcher", binaryMessenger: registrar.messenger())
    let instance = TaxiLauncherPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }


    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getInstalledTaxis":
            result(taxis.filter({ isTaxiAppAvailable(taxi: $0) }).map({ $0.toMap() }))

        case "launchTaxi":
            let args = call.arguments as! NSDictionary
            let taxiType = args["taxiAppType"] as! String
            let url = args["url"] as! String

            let taxi = getTaxiByRawTaxiAppType(type: taxiType)
        
            if (!isTaxiAppAvailable(taxi: taxi)) {
                result(FlutterError(code: "TAXI_NOT_AVAILABLE", message: "Taxi app is not installed on a device", details: nil))
                return;
            }

            showDirections(
                taxiType: taxi!.taxiAppType,
                url: taxi!.urlPrefix + url
            )
            result(nil)

        case "isTaxiAppAvailable":
            let args = call.arguments as! NSDictionary
            let taxiType = args["taxiAppType"] as! String
            let taxi = getTaxiByRawTaxiAppType(type: taxiType)
            result(isTaxiAppAvailable(taxi: taxi))

        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
