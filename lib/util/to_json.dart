import 'dart:convert';

import 'package:pos_flutter/data/database.dart';

Map<String, dynamic> productToJson(ProductData product) {
  return {
    'id': product.id,
    'name': product.name,
    'description': product.description,
    'price': product.price,
    'stock': product.stock,
    'sku': product.sku,
    'artworkId': product.artworkId,
  };
}

String inventoryToJson(List<ProductData> products) {
  List<Map<String, dynamic>> productList = products.map((product) => productToJson(product)).toList();
  return jsonEncode(productList);
}
