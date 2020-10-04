import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

class BluetoothCtl extends GetxController {
  bool isOn = false;
  bool isConnected = false;
  bool isScanning = false;
  List<BluetoothDevice> device = [];
  List<BluetoothDevice> bondedDevice = [];
  BluetoothDevice selectedDevice;
  BluetoothConnection connection;
  bluetoothState(bool param) {
    isOn = param;
    reload();
  }

  scanning(bool param) {
    isScanning = param;
    reload();
  }

  updateDevice(List<BluetoothDevice> param) {
    device = param;
    print(device);
    reload();
  }

  updateBondedDevice(List<BluetoothDevice> param) {
    bondedDevice = param;
    print(device);
    reload();
  }

  updateSelectedDevice(BluetoothDevice param) {
    selectedDevice = param;
    reload();
  }

  updateConnection(BluetoothConnection param) {
    connection = param;
    reload();
  }

  reload() {
    update();
  }
}
