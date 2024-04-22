import 'package:flutter/material.dart';
import 'package:orders_flutter/app/store/product_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductStore productStore = ProductStore();
  @override
  void initState() {
    productStore.getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Faça seu pedido',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Divider(),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Chip(label: Text('Categoria 1')),
                  SizedBox(width: 10),
                  Chip(label: Text('Categoria 1')),
                  SizedBox(width: 10),
                  Chip(label: Text('Categoria 1')),
                  SizedBox(width: 10),
                  Chip(label: Text('Categoria 1')),
                  SizedBox(width: 10),
                  Chip(label: Text('Categoria 1')),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Produtos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Expanded(
              child: ListenableBuilder(
                listenable: productStore,
                builder: (context, child) {
                  return productStore.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: productStore.products.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(productStore.products[index].title),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
