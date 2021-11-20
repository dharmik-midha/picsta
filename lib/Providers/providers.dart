import 'dart:io';

import 'package:flutter/material.dart';

class ImgProvider extends ChangeNotifier {
  late File _image;

  File getImage() => _image;

  setImage(File img) {
    _image = img;
    notifyListeners();
  }
}
