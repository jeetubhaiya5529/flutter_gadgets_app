// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/core/store.dart';
import 'package:flutter_application_2/models/cart.dart';
import 'package:flutter_application_2/models/catalog.dart';
import 'package:flutter_application_2/utils/routes.dart';
import 'package:flutter_application_2/widget/catalog_header.dart';
import 'package:flutter_application_2/widget/catalog_list.dart';
import 'package:flutter_application_2/widget/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadState();
  }

  void loadState() async {
    await Future.delayed(const Duration(seconds: 2));
    var catalogJson = await rootBundle.loadString("assets/files/catalog.json");
    var decodeData = jsonDecode(catalogJson);
    var productsData = decodeData["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cart = (VxState.store as MyStore).cart;
    return Scaffold(
      floatingActionButton: VxBuilder(
        mutations: const {AddMutation, RemoveMutation},
        builder: (context, _, __) => FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
          backgroundColor: MyTheme.lightBlueColor,
          child: const Icon(
            CupertinoIcons.cart,
            color: Colors.white,
          ),
        ).badge(color: Vx.red500, size: 20, count: cart!.items.length,textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), 
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: Container(
          padding: Vx.m8,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const CatalogHeader().p16(),
            if (CatalogModel.items != null && CatalogModel.items!.isNotEmpty)
              const CatalogList().expand()
            else
              const CircularProgressIndicator().centered().expand()
          ]),
        ),
      ),
    );
  }
}



/// before

// appBar: AppBar(
//   title: const Text('Products Page'),
// ),
// drawer: const Drawer(),
// body: Padding(
//   padding: const EdgeInsets.all(16.0),
//   child: (CatalogModel.items != null && CatalogModel.items!.isNotEmpty)
//       ? GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 16,
//               crossAxisCount: 2),
//           itemBuilder: (context, index) {
//             final item = CatalogModel.items![index];
//             return Card(
//               color: Colors.white,
//               clipBehavior: Clip.antiAlias,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               child: GridTile(
//                 header: Text(item.name),
//                 footer: Text(item.price.toString()),
//                 child: Image.network(item.image),
//               ),
//             );
//           },
//           itemCount: CatalogModel.items!.length,
//         )
//       // ListView.builder(
//       //     itemCount: CatalogModel.items!.length,
//       //     itemBuilder: (context, index) {
//       //       return ItemWidget(item: CatalogModel.items![index]);
//       //     })
//       : const Center(
//           child: CircularProgressIndicator(),
//         ),
// ),
