import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String hint;
  final Color textcolor;
  final Color bgcolor;
  final Function function;
  final double width;
  const CustomButton(
      {Key key,
      this.hint,
      this.textcolor,
      this.bgcolor,
      this.function,
      this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: bgcolor,
          boxShadow: [
            BoxShadow(
              color: textcolor,
              blurRadius: 3,
            )
          ]),
      child: FlatButton(
        child: Text(hint,
            style: GoogleFonts.poppins(
                color: textcolor, fontWeight: FontWeight.bold)),
        onPressed: function,
      ),
    );
  }
}
