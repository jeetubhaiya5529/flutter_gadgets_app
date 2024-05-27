import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/store.dart';
import 'package:flutter_application_2/models/cart.dart';
import 'package:velocity_x/velocity_x.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Cart".text.make(),
      ),
      body: Column(
        children: [
          _CartList().p32().expand(),
          const Divider(),
          _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  final CartModel? _cart = (VxState.store as MyStore).cart;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          VxConsumer(
            notifications: const {},
            mutations: const {RemoveMutation},
            builder: (context, _, __) {
              return "\$${_cart!.totalPrice}"
                  .text
                  .xl3
                  .color(context.theme.hintColor)
                  .make();
            },
          ),
          30.widthBox,
          TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: "Buying not supported yet.".text.make()));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(context.theme.hintColor)),
                  child: "Buy".text.white.make())
              .w32(context)
              .h8(context)
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VxConsumer(
      mutations: const {RemoveMutation},
      builder: (context, _, __) {
        final CartModel? cart = (VxState.store as MyStore).cart;
        return cart!.items.isEmpty
            ? "Cart is Empty".text.xl3.makeCentered()
            : ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  leading: const Icon(Icons.done),
                  trailing: IconButton(
                    onPressed: () {
                      RemoveMutation(cart.items[index]);
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  title: cart.items[index].name.text.make(),
                ),
              );
      },
    );
  }
}
