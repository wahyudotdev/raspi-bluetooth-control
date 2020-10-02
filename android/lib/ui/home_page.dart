import 'package:android/ui/choose_page.dart';
import 'package:android/ui/widget/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ui/widget/pixel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String a = 'Pilih nama perangkat bluetooth';
  bool connected = false;
  Widget appBar() {
    return AppBar(
      title: Text('Dispenser Minuman'),
      backgroundColor: Colors.white,
    );
  }

  Widget top() {
    return Expanded(
      flex: 3,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Flexible(
            flex: 2,
            child: Text(
              connected ? 'Bluetooth Aktif\n' : 'Bluetooth Tidak Aktif\n',
              style: GoogleFonts.poppins(
                  fontSize: Pixel.x * 5, color: Colors.white),
            ),
          ),
          Flexible(
            flex: 4,
            child: Container(
              width: Pixel.x * 50,
              padding: EdgeInsets.all(Pixel.x * 3),
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 5)
              ]),
              child: Icon(
                connected ? Icons.bluetooth : Icons.bluetooth_disabled,
                color: Colors.white,
                size: Pixel.x * 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bottom() {
    return Expanded(
      flex: 4,
      child: Container(
        padding: EdgeInsets.only(top: Pixel.y * 10),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            boxShadow: [
              BoxShadow(color: Colors.white, spreadRadius: 3, blurRadius: 3)
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
                    bgcolor: Colors.orange,
                    hint: connected ? 'OFF' : 'ON',
                    textcolor: Colors.white,
                    width: Pixel.x * 40,
                    function: () => setState(() => connected = !connected),
                  ),
                  CustomButton(
                    bgcolor: Colors.orange,
                    hint: 'SCAN',
                    textcolor: Colors.white,
                    width: Pixel.x * 40,
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: DropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Text(a),
                      value: a,
                    )
                  ],
                  value: a,
                  onChanged: (value) => print(value),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: CustomButton(
                  hint: 'CONNECT',
                  bgcolor: Colors.orange,
                  textcolor: Colors.white,
                  function: () => Get.to(ChoosePage()),
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
  }

  @override
  Widget build(BuildContext context) {
    Pixel().init(context);
    return Container(
      color: Colors.orangeAccent,
      child: SafeArea(
        child: Scaffold(
          // appBar: appBar(),
          backgroundColor: Colors.orangeAccent,
          body: Column(
            children: [top(), bottom()],
          ),
        ),
      ),
    );
  }
}
