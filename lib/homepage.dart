import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picsta/edit_photo_screen.dart';
import 'package:picsta/Providers/providers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    late File _image;

    Future _imgFromGallery() async {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Provider.of<ImgProvider>(context, listen: false).setImage(_image);

        Future.delayed(Duration(seconds: 0)).then(
          (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditPhotoScreen(),
            ),
          ),
        );
      }
    }

    return Column(
      children: <Widget>[
        Row(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30),
                child: Text(
                  'PICSTA',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 40.0,
                    fontFamily: 'Pacifico-Regular',
                    color: Color(0xff161B22),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
              child: SizedBox(
                child: Image.asset('images/logo.png'),
                width: 80,
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            children: [

              const Spacer(),
              IconButton(
                onPressed: () {
                  _imgFromGallery();
                },
                icon: Ink(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 4.0),
                    shape: BoxShape.circle,
                  ),
                  child: const InkWell(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Icon(
                        CupertinoIcons.add,
                        size: 70,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                iconSize: 180,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 55.0),
                child: Text(
                  'Import a photo to Start Editing...',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'MavenPro-SemiBold',
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            const Expanded(child: Text('')),
            FloatingActionButton(
              child: const Icon(Icons.add),
              backgroundColor: Color(0xff161B22),
              onPressed: () {
                _imgFromGallery();
              },
            ),
          ]),
        ),
      ],
    );
  }
}
