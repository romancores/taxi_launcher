import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taxi_launcher/taxi_launcher_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelTaxiLauncher platform = MethodChannelTaxiLauncher();
  const MethodChannel channel = MethodChannel('taxi_launcher');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });


}
