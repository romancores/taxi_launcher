package com.example.taxi_launcher

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


private enum class TaxiAppType { uber, careem, cabify, yango, dtc, yandexGo, grab, gojek, indrive }

private class TaxiAppModel(val taxiAppType: TaxiAppType, val taxiAppName: String, val packageName: String, val urlPrefix: String) {
    fun toMap(): Map<String, String> {
        return mapOf("taxiAppType" to taxiAppType.name, "taxiAppName" to taxiAppName, "urlPrefix" to urlPrefix)
    }
}

/** TaxiLauncherPlugin */
class TaxiLauncherPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "taxi_launcher")
        this.context = flutterPluginBinding.applicationContext
        channel?.setMethodCallHandler(this)
    }
    companion object {
        fun registerWith(
                @NonNull registrar: io.flutter.plugin.common.PluginRegistry.Registrar) {
            val taxiLauncherPlugin = TaxiLauncherPlugin()
            taxiLauncherPlugin.channel = MethodChannel(registrar.messenger(), "taxi_launcher")
            taxiLauncherPlugin.context = registrar.context()
            taxiLauncherPlugin.channel?.setMethodCallHandler(taxiLauncherPlugin)
        }
    }

    private val taxis = listOf(
            TaxiAppModel(TaxiAppType.uber, "Uber", "com.ubercab", "uber://"),
            TaxiAppModel(TaxiAppType.careem, "Careem", "com.careem.acma", "careeem://"),
            TaxiAppModel(TaxiAppType.cabify, "Cabify", "com.cabify.rider", "cabify://"),
            TaxiAppModel(TaxiAppType.yango, "Yango", "com.yandex.yango", "https://yango.go.link/en_int/order/"),
            TaxiAppModel(TaxiAppType.dtc, "DTC", "com.dtc.dtccustomer", "dtc://"),
            TaxiAppModel(TaxiAppType.yandexGo, "YandexGo", "com.yandex.go", "https://3.redirect.appmetrica.yandex.com/"),
            TaxiAppModel(TaxiAppType.grab, "Grab", "com.grabtaxi.passenger", "grab://"),
            TaxiAppModel(TaxiAppType.gojek, "Gojek", "com.gojek.app", "gojek://"),
            TaxiAppModel(TaxiAppType.indrive, "Indrive", "sinet.startup.inDriver", "indrive://")
    )

    private fun getInstalledTaxiApps(): List<TaxiAppModel> {
        return taxis.filter { taxi ->
            context.packageManager?.getLaunchIntentForPackage(taxi.packageName) != null
        }
    }

    private fun isTaxiAppAvailable(type: String): Boolean {
        val installedMaps = getInstalledTaxiApps()
        return installedMaps.any { taxi -> taxi.taxiAppType.name == type }
    }

    private fun launchTaxiApp(taxiAppType: TaxiAppType, url: String, result: Result) {
        context.let {
            val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            val foundMap = taxis.find { map -> map.taxiAppType == taxiAppType }
            if (foundMap != null) {
                intent.setPackage(foundMap.packageName)
            }
            it.startActivity(intent)
        }
        result.success(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getInstalledTaxis" -> {
                val installedTaxies = getInstalledTaxiApps()
                result.success(installedTaxies.map { taxi -> taxi.toMap() })
            }

            "launchTaxi" -> {
                val args = call.arguments as Map<*, *>

                if (!isTaxiAppAvailable(args["taxiAppType"] as String)) {
                    result.error("TAXIAPP_NOT_AVAILABLE", "Taxi is not installed on a device", null)
                    return
                }

                val taxiAppType = TaxiAppType.valueOf(args["taxiAppType"] as String)
                val url = args["url"] as String

                launchTaxiApp(taxiAppType, url, result)
            }

            "isTaxiAppAvailable" -> {
                val args = call.arguments as Map<*, *>
                result.success(isTaxiAppAvailable(args["taxiAppType"] as String))
            }

            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
