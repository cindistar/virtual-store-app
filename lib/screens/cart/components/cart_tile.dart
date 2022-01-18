import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';

import 'package:loja_virtual/models/cart_product.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;
  const CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed('/product', arguments: cartProduct.product);
        },
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network(cartProduct.product.images.first),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartProduct.product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Size: ${cartProduct.size}',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ),
                        Consumer<CartProduct>(
                          builder: (_, cartProduct, __) {
                            if (cartProduct.hasStock)
                              return Text(
                                '\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            else
                              return Text(
                                'Out of stock',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer<CartProduct>(
                  builder: (_, cartProduct, __) {
                    return Column(
                      children: [
                        CustomIconButton(
                          iconData: Icons.add,
                          color: Theme.of(context).primaryColor,
                          onTap: cartProduct.increment,
                        ),
                        Text(
                          '${cartProduct.quantity}',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        CustomIconButton(
                          iconData: Icons.remove,
                          color: cartProduct.quantity > 1
                              ? Theme.of(context).primaryColor
                              : Colors.red,
                          onTap: cartProduct.decrement,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
