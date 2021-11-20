import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:picsta/homepage.dart';
import 'package:picsta/Providers/providers.dart';
import 'package:provider/provider.dart';

//kotlin version: 1.5.30 in android > gradle > build.gradle >ext.kotlin_version = '1.5.30' for statusbar color
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ImgProvider()),
      ],
      child: const PicstaAppHome(),
    ),
  );
}

class PicstaAppHome extends StatelessWidget {
  const PicstaAppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xff161B22));
    FlutterStatusbarcolor.setNavigationBarColor(Color(0xff161B22));
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: HomePage(),
        ),
      ),
    );
  }
}
