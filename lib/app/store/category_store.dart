import 'package:flutter/material.dart';
import 'package:orders_flutter/app/shared/api_datasource.dart';

class CategoryStore extends ChangeNotifier {
  List<String> categories = [];
  bool isLoading = false;
  bool selected = false;
  IApiDatasource apiDatasource = ApiDatasource();
  void getCategories() async {
    isLoading = true;
    categories = await apiDatasource.getCategories();
    isLoading = false;
    notifyListeners();
  }
}
