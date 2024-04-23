import 'package:flutter/material.dart';
import 'package:orders_flutter/app/models/product_model.dart';
import 'package:orders_flutter/app/shared/api_datasource.dart';

class ProductStore extends ChangeNotifier {
  List<ProductModel> products = [];
  bool isLoading = false;
  List<ProductModel> originalProducts = [];
  String selectedCategory = '';
  IApiDatasource apiDatasource = ApiDatasource();
  void getProduct() async {
    isLoading = true;
    products = await apiDatasource.getProducts();
    originalProducts = products;
    isLoading = false;
    notifyListeners();
  }

  void productByCategory(String category) {
    products = originalProducts.where((element) => element.category == category).toList();
    selectedCategory = category;
    notifyListeners();
  }
}
