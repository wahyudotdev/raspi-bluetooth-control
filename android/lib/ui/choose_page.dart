import 'package:android/controller/bluetooth_ctl.dart';
import 'package:android/service/bluetooth_service.dart';
import 'package:android/ui/widget/custom_button.dart';
import 'package:android/ui/widget/pixel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChoosePage extends StatefulWidget {
  @override
  _ChoosePageState createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  Widget title() {
    return Positioned(
      top: Pixel.y * 10,
      left: Pixel.x * 10,
      width: Pixel.x * 80,
      child: Text(
        'Silahkan dipilih minumannya',
        textAlign: TextAlign.center,
        style:
            GoogleFonts.poppins(fontSize: Pixel.x * 5.5, color: Colors.white),
      ),
    );
  }

  Widget bottom() {
    return GetBuilder<BluetoothCtl>(
        init: BluetoothCtl(),
        builder: (bluetooth) {
          return Positioned(
              bottom: 0,
              width: Pixel.x * 100,
              height: Pixel.y * 70,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Pixel.x * 10),
                        topRight: Radius.circular(Pixel.x * 10))),
                child: Container(
                  width: Pixel.x * 100,
                  child: Stack(
                    children: [
                      Positioned(
                          top: Pixel.y * 10,
                          left: Pixel.x * 35,
                          child: InkWell(
                            onTap: () => BluetoothService.send('a'),
                            child: Container(
                              width: Pixel.x * 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.orange.withOpacity(0.3),
                                        blurRadius: 5,
                                        spreadRadius: 5)
                                  ]),
                              child: Image.asset('assets/ic_fanta.png'),
                            ),
                          )),
                      Positioned(
                          top: Pixel.y * 25,
                          left: Pixel.x * 15,
                          child: InkWell(
                            onTap: () => BluetoothService.send('b'),
                            child: Container(
                              width: Pixel.x * 25,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.red.withOpacity(0.3),
                                        blurRadius: 5,
                                        spreadRadius: 5)
                                  ]),
                              child: Image.asset('assets/ic_cola.png'),
                            ),
                          )),
                      Positioned(
                          top: Pixel.y * 25,
                          right: Pixel.x * 15,
                          child: InkWell(
                            onTap: () => BluetoothService.send('c'),
                            child: Container(
                              width: Pixel.x * 25,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.green.withOpacity(0.3),
                                        blurRadius: 5,
                                        spreadRadius: 5)
                                  ]),
                              child: Image.asset('assets/ic_sprite.png'),
                            ),
                          ))
                    ],
                  ),
                ),
              ));
        });
  }

  Widget button() {
    return Positioned(
      bottom: Pixel.y * 10,
      left: Pixel.x * 10,
      child: Row(
        children: [
          CustomButton(
            hint: 'Disconnect',
            bgcolor: Colors.blue,
            textcolor: Colors.white,
            width: Pixel.x * 35,
            function: () => BluetoothService.disconnect(),
          ),
          CustomButton(
            hint: 'Home',
            bgcolor: Colors.blue,
            textcolor: Colors.white,
            width: Pixel.x * 35,
            function: () => Get.back(),
          )
        ],
      ),
    );
  }

  void dispose() {
    super.dispose();
    BluetoothService.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    Pixel().init(context);
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: Stack(
            children: [title(), bottom(), button()],
          ),
        ),
      ),
    );
  }
}
