import 'package:flutter/material.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:loja_virtual/models/section.dart';

class AddSectionWidget extends StatelessWidget {
  AddSectionWidget(this.homeManager);

  final HomeManager homeManager;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          // ignore: deprecated_member_use
          child: FlatButton(
            onPressed: () {
              homeManager.addSection(Section(type: 'List'));
            },
            textColor: Colors.white,
            child: Text('Adicionar Lista'),
          ),
        ),
        Expanded(
          // ignore: deprecated_member_use
          child: FlatButton(
            onPressed: () {
              homeManager.addSection(Section(type: 'Staggered'));
            },
            textColor: Colors.white,
            child: Text('Adicionar Grade'),
          ),
        ),
      ],
    );
  }
}
