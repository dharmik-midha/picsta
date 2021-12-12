import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:picsta/TuneImage.dart';
import 'package:picsta/filter_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';
import 'Providers/providers.dart';

bool toggle = false;

class BottomEditingMenu extends StatefulWidget {
  BottomEditingMenu();

  @override
  _BottomEditingMenuState createState() => _BottomEditingMenuState();
}

class _BottomEditingMenuState extends State<BottomEditingMenu> {
  late File image;
  @override
  void initState() {
    super.initState();
  }

  Future getImage() async {
    // var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    // fileName = basename(imageFile.path);
  }

  filterFunction() {
    Future.delayed(Duration(seconds: 0)).then(
      (value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FilterImage(),
        ),
      ),
    );
  }

  Future<Null> cropFunction() async {
    File? cropFile = await ImageCropper.cropImage(
      compressQuality: 100,
      sourcePath: image.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Color(0xff161B22),
        toolbarWidgetColor: Color(0xffffffff),
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
        activeControlsWidgetColor: Colors.green,
      ),
    );
    if (cropFile != null) {
      image = cropFile;
      Provider.of<ImgProvider>(context, listen: false).setImage(image);
    }
  }

  effectsFunction() {}

  colorFunction() {
    // Future.delayed(Duration(seconds: 0)).then(
    //   (value) => Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => ,
    //     ),
    //   ),
    // );
  }

  tuneImageFunction() {
    Future.delayed(Duration(seconds: 0)).then(
      (value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TuneImage(),
        ),
      ),
    );
  }

  resetFunction() {
    Provider.of<ImgProvider>(context, listen: false).resetImage();
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
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Row(
              children: [
                FeatureIcon('Filters', EvaIcons.funnelOutline, filterFunction),
                const SizedBox(width: 5),
                FeatureIcon('Crop', EvaIcons.cropOutline, cropFunction),
                const SizedBox(width: 5),
                // FeatureIcon('Effects', EvaIcons.sunOutline, effectsFunction),
                // const SizedBox(width: 5),
                FeatureIcon(
                    'Color', EvaIcons.colorPaletteOutline, colorFunction),
                const SizedBox(width: 5),
                FeatureIcon(
                    'Tune Image', EvaIcons.optionsOutline, tuneImageFunction),
                const SizedBox(width: 5),
                FeatureIcon('Reset', EvaIcons.undoOutline, resetFunction),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
