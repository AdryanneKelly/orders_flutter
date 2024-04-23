import 'package:flutter/material.dart';
import 'package:orders_flutter/app/store/category_store.dart';
import 'package:orders_flutter/app/store/product_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductStore productStore = ProductStore();
  CategoryStore categoryStore = CategoryStore();
  @override
  void initState() {
    productStore.getProduct();
    categoryStore.getCategories();
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ListenableBuilder(
                listenable: Listenable.merge([categoryStore, productStore]),
                builder: (context, child) {
                  return categoryStore.isLoading
                      ? const Center(
                          child: SizedBox(width: 100, height: 5, child: LinearProgressIndicator()),
                        )
                      : Row(
                          children: categoryStore.categories
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    productStore.productByCategory(e);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Chip(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                          color: productStore.selectedCategory == e ? Colors.red : Colors.grey,
                                        ),
                                      ),
                                      label: Text(e),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                },
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
                            final product = productStore.products[index];
                            return ListTile(
                              leading: Image(
                                image: NetworkImage(product.image),
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return const CircularProgressIndicator();
                                },
                                height: 50,
                                width: 50,
                              ),
                              title: Text(product.title),
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
