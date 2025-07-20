import 'package:flutter/services.dart';
import 'package:flutter_search_module/models/product.dart';

class NativeSearchService {
  static const MethodChannel _platformChannel = MethodChannel('com.shopeee.app.search');

  Future<List<Product>> startSearch(String query) async {
    try {
      final Map<dynamic, dynamic> result = await _platformChannel.invokeMethod('startSearch', {'query': query});

      if (result['status'] == 'success') {
        final List<dynamic> productList = result['data'] as List<dynamic>;
        /* List<Product> products = productList.map((product) =>
          Product.fromMap(product as Map<String, dynamic>)).toList();
        return products; */
        return productList.map((product) {
          return Product.fromMap((product as Map).cast<String, dynamic>());
        }).toList();
      } else if (result['status'] == 'empty') {
        return List<Product>.empty();
      } else {
        return List<Product>.empty();
      }
    } on PlatformException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<Product>> loadNextPage() async {
    try {
      final Map<dynamic, dynamic> result = await _platformChannel.invokeMethod('loadNextPage');

      if (result['status'] == 'success') {
        final List<dynamic> productList = result['data'] as List<dynamic>;
        /* List<Product> products = productList.map((product) =>
          Product.fromMap(product as Map<String, dynamic>)).toList();
        
        return products; */
        return productList.map((product) {
          return Product.fromMap((product as Map).cast<String, dynamic>());
        }).toList();
      } else {
        return List<Product>.empty();
      }
    } on PlatformException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> navigateToProduct(Product product) async {
  try {
    await _platformChannel.invokeMethod('navigateToProduct', {'product': product.toMap()});
  } on PlatformException catch (e) {
    print(e.message);
  }
}
}