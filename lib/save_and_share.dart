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

class SaveAndShare extends StatefulWidget {
  const SaveAndShare({Key? key}) : super(key: key);

  @override
  _SaveAndShareState createState() => _SaveAndShareState();
}

class _SaveAndShareState extends State<SaveAndShare> {
  final GlobalKey globalKey = GlobalKey();
  late File image;
  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }

  ShareImage() {}
  CancelImage() {
    Future.delayed(Duration(seconds: 0)).then(
      (value) => Navigator.pop(context),
    );
  }

  SaveImage() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData =
        await (image.toByteData(format: ui.ImageByteFormat.png));
    print(byteData);
    if (byteData != null) {
      final result =
          await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      print(result);
      if (result.toString().contains('denied'))
        _toastInfo("Please Allow Storage Permission");
      else
        _toastInfo("File Saved in Gallery");
    }
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RepaintBoundary(
                    key: globalKey,
                    child: ClipRRect(
                      child: Image.file(
                        image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    )),
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
                        IconButton(
                          onPressed: () {
                            SaveImage();
                          },
                          icon: Icon(
                            EvaIcons.checkmark,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        SizedBox(width: 25),
                        IconButton(
                          onPressed: () {
                            CancelImage();
                          },
                          icon: Icon(
                            EvaIcons.close,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        SizedBox(width: 25),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            EvaIcons.share,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
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
