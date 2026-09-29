import 'package:bedrock_launcher/domain/services/battery_port.dart';

class GetBatteryLevelUseCase {
  const GetBatteryLevelUseCase(this._batteryPort);

  final BatteryPort _batteryPort;

  Future<int> call() => _batteryPort.getBatteryLevel();
}
