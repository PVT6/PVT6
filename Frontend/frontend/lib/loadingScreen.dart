import 'package:flutter/material.dart';


const colorBeige = const Color(0xFFF5F3EE);
const colorDarkBeige = const Color(0xFFc2c0bc);
const colorPrimaryRed = const Color(0xffEA9999);
const colorLightRed = const Color(0xFFffcaca);
const colorDarkRed = const Color(0xffb66a6b);

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: colorDarkBeige,),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                        width: 280,
                        height: 200,
                        child: Image.asset(
                          'assets/logopurplepink.png',
                        ),
                      ),

            ])
                ),
                )

          ])
        ],
      ),

      
      
    );
  }
}