import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({this.onImageSelected});

  final Function(File) onImageSelected;

  final ImagePicker picker = ImagePicker();

  Future<void> editImage(String path, BuildContext context) async {
    final File croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        aspectRatio: CropAspectRatio(
          ratioX: 1.0,
          ratioY: 1.0,
        ),
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Edit Image',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
        ),
        iosUiSettings: IOSUiSettings(
          title: 'Edit Imagem',
          cancelButtonTitle: 'Cancel',
          doneButtonTitle: 'Finish',
        ));
    if (croppedFile != null) {
      onImageSelected(croppedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () async {
                final PickedFile file =
                    await picker.getImage(source: ImageSource.camera);
                editImage(file.path, context);
              },
              child: Text(
                'Camera',
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () async {
                final PickedFile file =
                    await picker.getImage(source: ImageSource.gallery);
                editImage(file.path, context);
              },
              child: Text(
                'Galery',
              ),
            ),
          ],
        ),
      );
    else
      return CupertinoActionSheet(
        title: Text('Select photo to the item'),
        message: Text('Choose the photo origin'),
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop,
          child: Text('Cancel'),
        ),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () async {
              final PickedFile file =
                  await picker.getImage(source: ImageSource.camera);
              editImage(file.path, context);
            },
            child: Text('Camera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final PickedFile file =
                  await picker.getImage(source: ImageSource.camera);
              editImage(file.path, context);
            },
            child: Text('Galery'),
          ),
        ],
      );
  }
}
