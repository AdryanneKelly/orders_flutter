import 'package:flutter/material.dart';
import 'package:orders_flutter/app/models/product_model.dart';
import 'package:orders_flutter/app/shared/api_datasource.dart';

class ProductStore extends ChangeNotifier {
  List<ProductModel> products = [];
  bool isLoading = false;
  IApiDatasource apiDatasource = ApiDatasource();
  void getProduct() async {
    isLoading = true;
    products = await apiDatasource.getProducts();
    isLoading = false;
    notifyListeners();
  }
}
