import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageViewerComponent extends StatefulWidget {
  final imageFile;
  final state;
  ImageViewerComponent(this.imageFile, this.state);
  @override
  _ImageViewerComponentState createState() =>
      _ImageViewerComponentState(this.imageFile, this.state);
}

class _ImageViewerComponentState extends State<ImageViewerComponent> {
  String _imageFile;
  final state;

  _ImageViewerComponentState(this._imageFile, this.state);

  ImagePicker picker = ImagePicker();

  pickImage () async {
    final file = await picker.getImage(
          source: ImageSource.gallery);
    setState(() {
      _imageFile = file.path;
    });
  }

  removeImage() => {
        setState(() {
          _imageFile = null;
        })
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: <Widget>[
                  Image.file(File(_imageFile)),
                  ClipOval(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      height: 30.0,
                      width: 30.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        alignment: Alignment.center,
                        iconSize: 15.0,
                        color: Colors.red,
                        icon: Icon(Icons.close),
                        onPressed: removeImage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
