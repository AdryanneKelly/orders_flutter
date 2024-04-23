import 'dart:convert';

import 'package:orders_flutter/app/client/http_client.dart';
import 'package:orders_flutter/app/models/product_model.dart';

abstract class IApiDatasource {
  Future<List<ProductModel>> getProducts();
  Future<List<String>> getCategories();
}

class ApiDatasource implements IApiDatasource {
  IHttpClient httpClient = HttpClient();
  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await httpClient.get('https://fakestoreapi.com/products');
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => ProductModel.fromMap(e)).toList();
      }
      return throw Exception('Erro ao buscar produtos');
    } catch (e) {
      return throw Exception('Erro de conexão com a API');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      final response = await httpClient.get('https://fakestoreapi.com/products/categories');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print(data);
        return data.map((e) => e.toString()).toList();
      }
      return throw Exception('Erro ao buscar categorias');
    } catch (e) {
      return throw Exception('Erro de conexão com a API');
    }
  }
}
