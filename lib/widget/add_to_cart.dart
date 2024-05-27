import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/store.dart';
import 'package:flutter_application_2/models/cart.dart';
import 'package:flutter_application_2/models/catalog.dart';
import 'package:flutter_application_2/widget/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class AddToCart extends StatelessWidget {
  final Item catalog;

  const AddToCart({super.key, required this.catalog});

  @override
  Widget build(BuildContext context) {
    return VxConsumer(
      mutations: const {AddMutation, RemoveMutation},
      builder: (context, _, __) {
        final CartModel? cart = (VxState.store as MyStore).cart;
        bool isInCart = cart!.items.contains(catalog);
        return ElevatedButton(
          onPressed: () {
            if (!isInCart) {
              AddMutation(catalog);
              // setState(() {});
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MyTheme.darkBlueColor),
            shape: MaterialStateProperty.all(const StadiumBorder()),
          ),
          child: isInCart
              ? const Icon(
                  Icons.done,
                  color: Color.fromARGB(255, 255, 254, 254),
                )
              : const Icon(
                  CupertinoIcons.cart_badge_plus,
                  color: Colors.white,
                ),
        );
      },
    );
  }
}




