import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:loja_virtual/models/address.dart';
import 'package:screenshot/screenshot.dart';

class ExportAddressDialog extends StatelessWidget {
  ExportAddressDialog(this.address);

  final Address address;

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ship-to Address'),
      content: Screenshot(
        controller: screenshotController,
        child: Container(
          padding: EdgeInsets.all(8),
          color: Colors.white,
          child: Text(
            '${address.street}, ${address.number} ${address.complement}\n'
            '${address.district}\n'
            '${address.city}/${address.state}\n'
            '${address.zipCode}',
          ),
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            var file = await screenshotController.capture();
            await GallerySaver.saveImage(file.toString());
          },
          child: Text(
            'Export',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            )
          ),
        )
      ],
    );
  }
}
