import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:picsta/homepage.dart';
import 'package:picsta/Providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/services.dart';

//kotlin version: 1.5.30 in android > gradle > build.gradle >ext.kotlin_version = '1.5.30' for statusbar color
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: Splash());
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => ImgProvider()),
              ],
              child: const PicstaAppHome(),
            ),
          );
        }
      },
    );
  }
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

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          lightMode ? const Color(0xff161B22) : const Color(0xff161B22),
      body: Center(
          child: lightMode
              ? Image.asset('assets/splash.png', width: 75.0)
              : Image.asset('assets/splash.png', width: 75.0)),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
