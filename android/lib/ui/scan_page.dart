import 'package:android/controller/bluetooth_ctl.dart';
import 'package:android/service/bluetooth_service.dart';
import 'package:android/ui/widget/pixel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanning = true;

  Widget appbar() {
    return AppBar(
      title: GetBuilder<BluetoothCtl>(
        init: BluetoothCtl(),
        builder: (bluetooth) {
          return Text(
            bluetooth.isScanning ? 'Memindai . .' : 'Perangkat tersedia',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          );
        },
      ),
      backgroundColor: Colors.blue,
      actions: [
        GetBuilder<BluetoothCtl>(
            init: BluetoothCtl(),
            builder: (bluetooth) {
              return InkWell(
                onTap: () => bluetooth.isOn
                    ? BluetoothService.discover()
                    : Get.defaultDialog(
                        title: 'Bluetooth belum menyala',
                        content: Text('Klik OK untuk menyalakan bluetooth'),
                        confirm: FlatButton.icon(
                          icon: Icon(Icons.check),
                          label: Text('OK'),
                          onPressed: () =>
                              BluetoothService.enable().then((_) => Get.back()),
                        ),
                        cancel: FlatButton.icon(
                          icon: Icon(Icons.cancel),
                          label: Text('Batal'),
                          onPressed: () => Get.back(),
                        ),
                      ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: bluetooth.isScanning
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Icon(Icons.refresh),
                ),
              );
            })
      ],
    );
  }

  static TextStyle style() {
    return GoogleFonts.poppins(color: Colors.white);
  }

  Widget deviceList() {
    return GetBuilder<BluetoothCtl>(
        init: BluetoothCtl(),
        // initState: BluetoothService.discover(),
        builder: (bluetooth) {
          if (bluetooth.device.isEmpty || bluetooth.device == null)
            return Text(
              'kosong',
              style: GoogleFonts.poppins(fontSize: Pixel.x * 5),
            );
          return Container(
            width: Pixel.x * 90,
            height: Pixel.y * 80,
            child: ListView.builder(
              itemCount: bluetooth.device.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(Pixel.x * 3),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 3,
                        )
                      ]),
                  child: ListTile(
                    leading: Icon(
                      Icons.bluetooth_searching,
                      color: Colors.white,
                      size: Pixel.x * 8,
                    ),
                    title: Text(
                      bluetooth.device[index].name,
                      style: style(),
                    ),
                    subtitle: Text(
                      bluetooth.device[index].address,
                      style: style(),
                    ),
                    trailing: Icon(
                      Icons.compare_arrows,
                      color: bluetooth.device[index].isBonded
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    onTap: () => bluetooth.device[index].isBonded
                        ? Get.snackbar(
                            'Info',
                            'Device telah dipair',
                            colorText: Colors.white,
                            backgroundColor: Colors.blue,
                          )
                        : Get.defaultDialog(
                            title: 'Pair device?',
                            content: Column(
                              children: [
                                Text(bluetooth.device[index].name),
                                Text(bluetooth.device[index].address)
                              ],
                            ),
                            cancel: FlatButton.icon(
                              icon: Icon(Icons.cancel),
                              label: Text('Batal'),
                              onPressed: () => Get.back(),
                            ),
                            confirm: FlatButton.icon(
                                icon: Icon(Icons.check),
                                label: Text('Pair'),
                                onPressed: () => BluetoothService.bond(
                                        bluetooth.device[index].address)
                                    .then((value) => Get.back())),
                          ),
                  ),
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Pixel().init(context);
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          appBar: appbar(),
          backgroundColor: Colors.white,
          body: GetBuilder<BluetoothCtl>(
              init: BluetoothCtl(),
              builder: (bluetooth) {
                return Center(
                  child: bluetooth.isScanning
                      ? Lottie.asset('assets/bluetooth.json')
                      : deviceList(),
                );
              }),
        ),
      ),
    );
  }
}
