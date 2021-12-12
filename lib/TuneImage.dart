import 'package:flutter/material.dart';
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
import 'package:path_provider/path_provider.dart';
import 'package:themed/themed.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class TuneImage extends StatefulWidget {
  const TuneImage({Key? key}) : super(key: key);

  @override
  _TuneImageState createState() => _TuneImageState();
}

class _TuneImageState extends State<TuneImage> {
  final GlobalKey globalKey = GlobalKey();
  late File image;
  double brightness = 0.0;
  double hue = 0.0;
  double saturation = 0.0;

  saveImage() async {
    late File imgFile;
    var rng = new Random();
    final RenderRepaintBoundary repaintBoundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 2.0);
    final ByteData? byteData =
        await boxImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8list = byteData!.buffer.asUint8List();
    final directory = (await getTemporaryDirectory()).path;
    imgFile = new File('$directory' + (rng.nextInt(100)).toString() + '.png');
    imgFile.writeAsBytes(uint8list);
    Provider.of<ImgProvider>(context, listen: false).setImage(imgFile);
    Future.delayed(Duration(seconds: 0)).then(
      (value) => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    image = Provider.of<ImgProvider>(context).getImage();
    return Scaffold(
      appBar: AppBar(
        title: Text('Tune Image'),
        backgroundColor: Color(0xff161B22),
        actions: [
          IconButton(
            onPressed: () {
              saveImage();
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              child: RepaintBoundary(
                key: globalKey,
                child: ClipRRect(
                  child: ChangeColors(
                    hue: hue,
                    brightness: brightness,
                    saturation: saturation,
                    child: PinchZoom(
                      resetDuration: const Duration(milliseconds: 100),
                      maxScale: 2.5,
                      child: Image.file(
                        image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Icon(
                            EvaIcons.sunOutline,
                            color: Colors.green,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 10.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 17.0),
                              overlayColor: Color(0x294CAF50),
                              thumbColor: Color(0xFF4CAF50),
                              inactiveTrackColor: Color(0xFF8D8E98),
                              activeTrackColor: Colors.green.shade500,
                              trackShape: RoundedRectSliderTrackShape(),
                              trackHeight: 2.0,
                            ),
                            child: Slider(
                              label: 'Brightness',
                              value: brightness.toDouble(),
                              min: -1.0,
                              max: 1.0,
                              onChanged: (double newValue) {
                                setState(() {
                                  brightness = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Icon(
                            EvaIcons.moonOutline,
                            color: Colors.green,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 10.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 17.0),
                              overlayColor: Color(0x294CAF50),
                              thumbColor: Color(0xFF4CAF50),
                              inactiveTrackColor: Color(0xFF8D8E98),
                              activeTrackColor: Colors.green.shade500,
                              trackShape: RoundedRectSliderTrackShape(),
                              trackHeight: 2.0,
                            ),
                            child: Slider(
                              label: 'Hue',
                              value: hue.toDouble(),
                              min: -1.0,
                              max: 1.0,
                              onChanged: (double newValue) {
                                setState(() {
                                  hue = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Icon(
                            EvaIcons.dropletOutline,
                            color: Colors.green,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 10.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 17.0),
                              overlayColor: Color(0x294CAF50),
                              thumbColor: Color(0xFF4CAF50),
                              inactiveTrackColor: Color(0xFF8D8E98),
                              activeTrackColor: Colors.green.shade500,
                              trackShape: RoundedRectSliderTrackShape(),
                              trackHeight: 2.0,
                            ),
                            child: Slider(
                              label: 'Saturation',
                              value: saturation.toDouble(),
                              min: -1.0,
                              max: 1.0,
                              onChanged: (double newValue) {
                                setState(() {
                                  saturation = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
