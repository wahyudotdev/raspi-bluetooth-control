import 'package:android/ui/widget/color_material.dart';
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
        style: GoogleFonts.poppins(fontSize: Pixel.x * 5, color: Colors.white),
      ),
    );
  }

  Widget bottom() {
    var icon = Container(
      width: Pixel.x * 100,
      child: Stack(
        children: [
          Positioned(
              top: Pixel.y * 10,
              left: Pixel.x * 35,
              child: Container(
                width: Pixel.x * 30,
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                      color: Colors.orangeAccent.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 5)
                ]),
                child: Image.asset('assets/ic_fanta.png'),
              )),
          Positioned(
              top: Pixel.y * 25,
              left: Pixel.x * 15,
              child: Container(
                width: Pixel.x * 25,
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                      color: Colors.orangeAccent.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 5)
                ]),
                child: Image.asset('assets/ic_cola.png'),
              )),
          Positioned(
              top: Pixel.y * 25,
              right: Pixel.x * 15,
              child: InkWell(
                onTap: () => print('sprite'),
                child: Container(
                  width: Pixel.x * 25,
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
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
    );
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
          child: icon,
        ));
  }

  Widget button() {
    return Positioned(
      bottom: Pixel.y * 10,
      left: Pixel.x * 10,
      child: Row(
        children: [
          CustomButton(
            hint: 'Disconnect',
            bgcolor: Colors.orange,
            textcolor: Colors.white,
            width: Pixel.x * 35,
          ),
          CustomButton(
            hint: 'Home',
            bgcolor: Colors.orange,
            textcolor: Colors.white,
            width: Pixel.x * 35,
            function: () => Get.back(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Pixel().init(context);
    return Container(
      color: ColorMaterial.orange,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorMaterial.orange,
          body: Stack(
            children: [title(), bottom(), button()],
          ),
        ),
      ),
    );
  }
}
