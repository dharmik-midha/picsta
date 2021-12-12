import 'package:flutter/material.dart';
import 'package:picsta/filters.dart';
import 'package:provider/provider.dart';
import 'package:picsta/Providers/providers.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'dart:io';
import 'dart:ui';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:screenshot/screenshot.dart';

class SaveAndShare extends StatefulWidget {
  const SaveAndShare({Key? key}) : super(key: key);

  @override
  _SaveAndShareState createState() => _SaveAndShareState();
}

class _SaveAndShareState extends State<SaveAndShare> {
  ScreenshotController screenshotController = ScreenshotController();
  final GlobalKey globalKey = GlobalKey();
  late File image;
  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }

  ShareImage() async {
    print(image.path);
    await Share.shareFiles([image.path], text: '');
  }

  CancelImage() {
    Future.delayed(Duration(seconds: 0)).then(
      (value) => Navigator.pop(context),
    );
  }

  //
  // SaveImage() async {
  //   RenderRepaintBoundary boundary =
  //       globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   ui.Image image = await boundary.toImage(pixelRatio: 2.0);
  //   ByteData? byteData =
  //       await (image.toByteData(format: ui.ImageByteFormat.png));
  //   if (byteData != null) {
  //     final result =
  //         await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
  //     print(result);
  //
  //
  //   }
  // }

  Future<String> saveImg(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'Picsta_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    if (result.toString().contains('denied'))
      _toastInfo("Please Allow Storage Permission");
    else
      _toastInfo("Image Saved in Gallery");
    Future.delayed(Duration(seconds: 0)).then(
      (value) => Navigator.of(context).popUntil((route) => route.isFirst),
    );
    return result['filePath'];
  }

  SaveImage() async {
    final image = await screenshotController.capture();
    if (image == null) {
      return;
    }
    await saveImg(image);
    print(image);
  }

  FeatureIcon(var name, var icon, var function) {
    return TextButton(
      onPressed: () {
        function();
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              icon,
              color: const Color(0xffffffff),
              size: 25,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: const TextStyle(
                color: Color(0xffffffff), fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    image = Provider.of<ImgProvider>(context).getImage();
    return Scaffold(
      appBar: AppBar(
        title: Text('Save & Share Image...'),
        backgroundColor: Color(0xff161B22),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              child: PinchZoom(
                resetDuration: const Duration(milliseconds: 100),
                maxScale: 2.5,
                child: Screenshot(
                  controller: screenshotController,
                  child: Image.file(
                    image,
                    // width: double.infinity,
                    // height: double.infinity,
                    // fit: BoxFit.contain,
                  ),
                ),
              ),
              color: Colors.black,
            ),
          ),
          Container(
            width: double.infinity,
            color: Color(0xff161b22),
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                      children: [
                        FeatureIcon('Save', Icons.check, SaveImage),
                        const SizedBox(width: 55),
                        FeatureIcon('Share', EvaIcons.shareOutline, ShareImage),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
