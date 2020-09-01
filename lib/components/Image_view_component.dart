import 'dart:io';

import 'package:daily_basket_sellers/components/image_viewer_component.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageView extends FormField {
  ImageView({
    FormFieldSetter onSaved,
    FormFieldValidator validator,
    // ignore: avoid_init_to_null
    String image,
    bool autovalidate = false,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: image,
            autovalidate: autovalidate,
            builder: (FormFieldState state) {
              ImagePicker picker = ImagePicker();
              void pickImage() async {
                final file = await picker.getImage(source: ImageSource.gallery);
                if (file != null) {
                  state.didChange(file.path);
                }
              }

              void removeImage() {
                state.didChange(null);
              }

              return state.value == null
                  ? IconButton(icon: Icon(Icons.add), onPressed: pickImage)
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: <Widget>[
                            state.value != null &&
                                    state.value.startsWith('https')
                                ? Image.network(state.value)
                                : Image.file(File(state.value)),
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
            });
}
