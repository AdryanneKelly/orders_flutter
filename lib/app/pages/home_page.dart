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
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.red,
              size: 35,
            ),
            SizedBox(width: 10),
            Text(
              'Flutter Shop',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Faça seu pedido',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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
                                          width: 1.5,
                                          color: productStore.selectedCategory == e ? Colors.red : Colors.grey,
                                        ),
                                      ),
                                      label: Text(
                                        e,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                },
              ),
            ),
            const SizedBox(height: 15),
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
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                leading: Image(
                                  image: NetworkImage(product.image),
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                  height: 70,
                                  width: 70,
                                ),
                                title: Text(
                                  product.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  product.description,
                                  maxLines: 3,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
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
