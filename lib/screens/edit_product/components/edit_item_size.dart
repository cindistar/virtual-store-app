import 'package:flutter/material.dart';

import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  const EditItemSize({
    Key key,
    this.size,
    this.onRemove,
    this.onMoveUp,
    this.onMoveDown,
  }) : super(key: key);

  final ItemSize size;

  final VoidCallback onRemove;

  final VoidCallback onMoveUp;

  final VoidCallback onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.name,
            decoration: InputDecoration(
              labelText: 'Title',
              isDense: true,
            ),
            validator: (name) {
              if (name.isEmpty) return 'Invalid';
              return null;
            },
            onChanged: (name) => size.name = name,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            decoration: InputDecoration(
              labelText: 'Stock',
              isDense: true,
            ),
            keyboardType: TextInputType.number,
            validator: (stock) {
              if (int.tryParse(stock) == null) return 'Invalid';
              return null;
            },
            onChanged: (stock) => size.stock = int.tryParse(stock),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.price?.toStringAsFixed(2),
            decoration: InputDecoration(
              labelText: 'Price',
              isDense: true,
              prefixText: '\$ ',
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (price) {
              if (num.tryParse(price) == null) 
                return 'Invalid';
              return null;
            },
            onChanged: (price) => size.price = num.tryParse(price),
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        ),
      ],
    );
  }
}
