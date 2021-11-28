import 'dart:io';

import 'package:flutter/material.dart';

class ImgProvider extends ChangeNotifier {
  late File _image;
  var index = 0;
  List _images = [];
  //
  // File getImage() => _image;
  //
  // setImage(File img) {
  //   _image = img;
  //   notifyListeners();
  // }

  File getImage() => _images[index];

  setImage(File img) {
    if (_images.length == 0) {
      _images.add(img);
    } else {
      _images.add(img);
      // print(_images.length);
      index = _images.length - 1;
    }
    notifyListeners();
  }

  previousImage() {
    // print(index);
    if (_images.length > 0 && index > 0) {
      index--;
    }
    notifyListeners();
  }

  nextImage() {
    // print(index);
    if (index < _images.length - 1) {
      index++;
    }
    notifyListeners();
  }

  resetImage() {
    for (var i = _images.length - 1; i > 0; i--) {
      _images.removeLast();
    }
    index = 0;
    notifyListeners();
  }
}
