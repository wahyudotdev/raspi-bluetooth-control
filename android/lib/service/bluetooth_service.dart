import 'dart:typed_data';

import 'package:android/controller/bluetooth_ctl.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

class BluetoothService {
  static final ctl = Get.put(BluetoothCtl());

  static init() async {
    bool ison = await FlutterBluetoothSerial.instance.isEnabled;
    ctl.bluetoothState(ison);
  }

  static bondedDevice() {
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((device) => ctl.updateBondedDevice(device));
  }

  static Future<void> enable() async {
    await FlutterBluetoothSerial.instance
        .requestEnable()
        .then((value) => ctl.bluetoothState(value));
  }

  static disable() async {
    await FlutterBluetoothSerial.instance
        .requestDisable()
        .then((value) => ctl.bluetoothState(false));
  }

  static discover() async {
    List<BluetoothDevice> device = [];
    ctl.scanning(true);
    var _discover =
        FlutterBluetoothSerial.instance.startDiscovery().listen((event) {
      print('perangkat => ${event.device}');
      device.add(event.device);
    });
    _discover.onDone(() {
      print('scan selesai');
      ctl.updateDevice(device);
      ctl.scanning(false);
    });
    Future.delayed(Duration(seconds: 10), () {
      _discover.cancel();
      ctl.updateDevice(device);
      ctl.scanning(false);
    });
  }

  static Future<void> bond(String address) async {
    await FlutterBluetoothSerial.instance
        .bondDeviceAtAddress(address)
        .then((value) => print(value))
        .catchError((e) {
      print(e);
      Get.snackbar('Gagal', 'gagal pairing device');
    });
  }

  static List<int> convertToAscii(String data) {
    List<int> list = [];
    for (int i = 0; i < data.length; i++) {
      list.add(data.codeUnitAt(i));
    }
    return list;
  }

  static Future<void> connect(String address) async {
    await BluetoothConnection.toAddress(address)
        .then((value) => ctl.updateConnection(value))
        .catchError((e) => print(e));
  }

  static Future<void> send(String cmd) async {
    ctl.connection.output.add(Uint8List.fromList(convertToAscii(cmd)));
  }

  static Future<void> disconnect() async {
    await ctl.connection.finish();
    ctl.connection.dispose();
  }
}
