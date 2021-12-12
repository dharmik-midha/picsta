import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picsta/appbar_generator.dart';
import 'package:picsta/bottom_editing_menu.dart';
import 'package:picsta/Providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class EditPhotoScreen extends StatefulWidget {
  EditPhotoScreen();
  @override
  _EditPhotoScreenState createState() => _EditPhotoScreenState();
}

class _EditPhotoScreenState extends State<EditPhotoScreen> {
  late File image;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    image = Provider.of<ImgProvider>(context).getImage();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarGenerator(),
            Expanded(
              flex: 8,
              child: Container(
                child: image != null
                    ? PinchZoom(
                        resetDuration: const Duration(milliseconds: 100),
                        maxScale: 2.5,
                        child: Image.file(
                          image,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
                color: Colors.black,
              ),
            ),
            Container(
              width: double.infinity,
              child: BottomEditingMenu(),
              color: const Color(0xff161B22),
            ),
          ],
        ),
      ),
    );
  }
}
