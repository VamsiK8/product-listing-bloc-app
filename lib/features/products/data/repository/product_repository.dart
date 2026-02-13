import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

abstract class ProductRepositoryInterface {
  Future<List<Product>> fetchProducts({int limit = 10});
}

class ProductRepository implements ProductRepositoryInterface{
  @override
  Future<List<Product>> fetchProducts({int limit = 10}) async {
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/products?limit=$limit"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}
