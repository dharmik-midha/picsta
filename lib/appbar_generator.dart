import 'dart:io';
import 'dart:typed_data';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/rendering.dart';
import 'package:picsta/save_and_share.dart';
import 'package:provider/provider.dart';
import 'Providers/providers.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';

class AppBarGenerator extends StatefulWidget {
  @override
  _AppBarGeneratorState createState() => _AppBarGeneratorState();
}

class _AppBarGeneratorState extends State<AppBarGenerator> {
  _saveImage() {
    Future.delayed(Duration(seconds: 0)).then(
      (value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SaveAndShare(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: Container(
        color: const Color(0xff161B22),
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                Future.delayed(Duration(seconds: 0)).then(
                  (value) => Navigator.pop(context),
                );
              },
              child: Row(
                children: const [
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    EvaIcons.plusCircleOutline,
                    color: Colors.white,
                    size: 28,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'New',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Provider.of<ImgProvider>(context, listen: false)
                        .previousImage();
                  },
                  icon: const FaIcon(EvaIcons.arrowBackOutline),
                  color: const Color(0xffffffff),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<ImgProvider>(context, listen: false)
                        .nextImage();
                  },
                  icon: const FaIcon(EvaIcons.arrowForwardOutline),
                  color: const Color(0xffffffff),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                _saveImage();
              },
              icon: const Icon(
                EvaIcons.saveOutline,
                size: 30,
              ),
              color: const Color(0xffffffff),
            ),
          ],
        ),
      ),
    );
  }
}
