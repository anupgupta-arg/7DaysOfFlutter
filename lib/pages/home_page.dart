import 'dart:convert';

import 'package:catalog/models/catalog.dart';
import 'package:catalog/widgets/item_widget.dart';
import 'package:flutter/services.dart';

import '../widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    final catalogJson =
        await rootBundle.loadString("assets/files/catalog.json");
    final decodeData = jsonDecode(catalogJson);
    var productData = decodeData["products"];
    CatalogModel.items =
        List.from(productData).map<Item>((json) => Item.fromMap(json)).toList();
    setState(() {});
  }

  final days = 7;

  final name = 'Geekguns';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: (CatalogModel.items != null && CatalogModel.items!.isNotEmpty)
            ? const ProductGridView()
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      drawer: MyDrawer(),
    );
  }
}

class ProductListView extends StatelessWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: CatalogModel.items?.length ?? 0,
      itemBuilder: (context, index) => ItemWidget(
        item: CatalogModel.items![index],
      ),
    );
  }
}

class ProductGridView extends StatelessWidget {
  const ProductGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final item = CatalogModel.items![index];
        return Card(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: GridTile(
              header: Container(
                child: Text(
                  item.name!,
                  style: const TextStyle(color: Colors.white),
                ),
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                ),
              ),
              child: Image.network(
                item.image!,
              ),
              footer: Container(
                child: Text(
                  item.price.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
            ));
      },
      itemCount: CatalogModel.items!.length,
    );
  }
}
