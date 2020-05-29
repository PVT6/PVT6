import "package:flutter/material.dart";
import 'package:frontend/loginFiles/MySignInPage.dart';




class GradientAppBar extends StatelessWidget {
TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
static const colorPurple = const Color(0xFF82658f);
static const colorPeachPink = const Color(0xFFffdcd2);
static const colorLighterPink = const Color(0xFFffe9e5);
  final String title;
  final double barHeight = 50.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Center(
        child: Text(
          title,
          style: style.copyWith(fontSize: 20.0, color: Colors.grey.shade800, fontWeight: FontWeight.bold),
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [colorDarkRed, colorLightRed],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp
        ),
      ),
    );
  }
}