import 'package:flutter/material.dart';
import 'package:picsta/filters.dart';
import 'package:provider/provider.dart';
import 'package:picsta/Providers/providers.dart';
import 'dart:io';
import 'dart:ui';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class FilterImage extends StatefulWidget {
  const FilterImage({Key? key}) : super(key: key);

  @override
  _FilterImageState createState() => _FilterImageState();
}

List filter = [
  'Sepia',
  'GreyScale',
  'Vintage',
  'Sweet',
  'Haze',
  'Polariser',
  'Classic',
  'Sky Line'
];
List toggle = [true, false, false, false, false, false, false, false];

class _FilterImageState extends State<FilterImage> {
  late File image;
  late File img;
  int imgIndex = 0;

  final GlobalKey globalKey = GlobalKey();
  final List<List<double>> filters = [
    SEPIA_MATRIX,
    GREYSCALE_MATRIX,
    VINTAGE_MATRIX,
    SWEET_MATRIX,
    HAZE_MATRIX,
    POLARISER_MATRIX,
    CLASSIC_MATRIX,
    SKYLINE_MATRIX
  ];

  void convertWidgetToImage() async {
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
    toggle = [true, false, false, false, false, false, false, false];
    Future.delayed(Duration(seconds: 0)).then(
      (value) => Navigator.pop(context),
    );
  }

  Widget filterIterator(var index) {
    return Container(
      padding: EdgeInsets.all(3),
      child: TextButton(
        child: Text(
          filter[index],
          textAlign: TextAlign.center,
          style: TextStyle(
            color: (toggle[index] == true ? Colors.green : Colors.white),
          ),
        ),
        onPressed: () {
          setState(() {
            this.imgIndex = index;
            toggle[imgIndex] = true;
            for (int i = 0; i < toggle.length; i++) {
              if (i != index) {
                toggle[i] = false;
              }
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    image = Provider.of<ImgProvider>(context).getImage();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Image Filters",
        ),
        backgroundColor: Color(0xff161b22),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: convertWidgetToImage,
          ),
        ],
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
                  child: ColorFiltered(
                    colorFilter: ColorFilter.matrix(filters[imgIndex]),
                    child: PinchZoom(
                      resetDuration: const Duration(milliseconds: 100),
                      maxScale: 2.5,
                      child: Image.file(
                        image,
                        width: size.width,
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                      children: [
                        filterIterator(0),
                        SizedBox(width: 5),
                        filterIterator(1),
                        SizedBox(width: 5),
                        filterIterator(2),
                        SizedBox(width: 5),
                        filterIterator(3),
                        SizedBox(width: 5),
                        filterIterator(4),
                        SizedBox(width: 5),
                        filterIterator(5),
                        SizedBox(width: 5),
                        filterIterator(6),
                        SizedBox(width: 5),
                        filterIterator(7)
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
