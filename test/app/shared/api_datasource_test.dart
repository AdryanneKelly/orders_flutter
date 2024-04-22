import 'package:flutter_test/flutter_test.dart';
import 'package:orders_flutter/app/shared/api_datasource.dart';

void main() {
  testWidgets('api datasource ...', (tester) async {
    IApiDatasource apiDatasource = ApiDatasource();
    final products = await apiDatasource.getProducts();
  });
}
