import 'package:android/controller/bluetooth_ctl.dart';
import 'package:android/service/bluetooth_service.dart';
import 'package:android/ui/scan_page.dart';
import 'package:android/ui/widget/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ui/widget/pixel.dart';
import 'choose_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget appBar() {
    return AppBar(
      title: Text('Dispenser Minuman'),
      backgroundColor: Colors.white,
    );
  }

  Widget top() {
    return Expanded(
      flex: 3,
      child: GetBuilder<BluetoothCtl>(
          init: BluetoothCtl(),
          builder: (bluetooth) {
            return Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                Flexible(
                  flex: 2,
                  child: Text(
                    bluetooth.isOn
                        ? 'Bluetooth Aktif\n'
                        : 'Bluetooth Tidak Aktif\n',
                    style: GoogleFonts.poppins(
                        fontSize: Pixel.x * 5, color: Colors.white),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    width: Pixel.x * 50,
                    padding: EdgeInsets.all(Pixel.x * 3),
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 5),
                      BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 5),
                    ]),
                    child: Icon(
                      bluetooth.isOn
                          ? Icons.bluetooth
                          : Icons.bluetooth_disabled,
                      color: Colors.white,
                      size: Pixel.x * 30,
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  Widget bottom() {
    return GetBuilder<BluetoothCtl>(
        init: BluetoothCtl(),
        builder: (bluetooth) {
          return Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.only(top: Pixel.y * 10),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white, spreadRadius: 3, blurRadius: 3)
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Pixel.x * 10),
                      topRight: Radius.circular(Pixel.x * 10))),
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            bgcolor: Colors.blue,
                            hint: bluetooth.isOn ? 'OFF' : 'ON',
                            textcolor: Colors.white,
                            width: Pixel.x * 40,
                            function: () => bluetooth.isOn
                                ? BluetoothService.disable()
                                : BluetoothService.enable(),
                          ),
                          CustomButton(
                            bgcolor: Colors.blue,
                            hint: 'SCAN',
                            textcolor: Colors.white,
                            width: Pixel.x * 40,
                            function: () => Get.to(ScanPage()),
                          ),
                        ],
                      )),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                      flex: 1,
                      child: CustomButton(
                        width: Pixel.x * 50,
                        textcolor: Colors.blue,
                        bgcolor: Colors.white,
                        hint: bluetooth.selectedDevice.isNull
                            ? 'Pilih device'
                            : bluetooth.selectedDevice.name,
                        function: () {
                          BluetoothService.bondedDevice();
                          Get.defaultDialog(
                            title: 'Pilih device',
                            content: Container(
                              width: Pixel.x * 60,
                              height: Pixel.y * 50,
                              child: ListView.builder(
                                itemCount: bluetooth.bondedDevice.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Icon(
                                      bluetooth.bondedDevice[index].isConnected
                                          ? Icons.compare_arrows
                                          : Icons.bluetooth_searching,
                                      size: Pixel.x * 8,
                                    ),
                                    title: Text(
                                        bluetooth.bondedDevice[index].name),
                                    subtitle: Text(
                                        bluetooth.bondedDevice[index].address),
                                    onTap: () {
                                      bluetooth.updateSelectedDevice(
                                          bluetooth.bondedDevice[index]);
                                      Get.back();
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      )),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: CustomButton(
                        hint: 'CONNECT',
                        bgcolor: Colors.blue,
                        textcolor: Colors.white,
                        function: () => BluetoothService.connect(
                          bluetooth.selectedDevice.address,
                        ).then(
                          (value) => Get.to(
                            ChoosePage(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  )
                ],
              ),
            ),
          );
        });
  }

  void initState() {
    super.initState();
    BluetoothService.init();
  }

  void dispose() {
    super.dispose();
    var ctl = Get.put(BluetoothCtl());
    ctl.connection.finish();
    ctl.connection.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Pixel().init(context);
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          // appBar: appBar(),
          backgroundColor: Colors.blue,
          body: Column(
            children: [top(), bottom()],
          ),
        ),
      ),
    );
  }
}
