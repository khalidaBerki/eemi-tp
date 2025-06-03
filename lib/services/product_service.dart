import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String baseUrl = 'https://eemi-39b84a24258a.herokuapp.com';

  Future<List<Product>> getProducts({
    String? search,
    int? limit,
    int? offset,
  }) async {
    try {
      final queryParameters = <String, String>{};
      if (search != null && search.isNotEmpty) queryParameters['search'] = search;
      if (limit != null) queryParameters['limit'] = limit.toString();
      if (offset != null) queryParameters['offset'] = offset.toString();

      final uri = Uri.parse('$baseUrl/products').replace(queryParameters: queryParameters);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        final List<dynamic> jsonList = jsonMap['rows'];
        return jsonList.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<Product> createProduct(Product product) async {
    try {
      final uri = Uri.parse('$baseUrl/products');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );
      if (response.statusCode == 201) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }

  Future<Product> updateProduct(Product product) async {
    if (product.id == null) {
      throw Exception('Product ID is required for update');
    }
    try {
      final uri = Uri.parse('$baseUrl/products/${product.id}');
      final response = await http.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );
      if (response.statusCode == 200) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final uri = Uri.parse('$baseUrl/products/$id');
      final response = await http.delete(uri);
      if (response.statusCode != 204) {
        throw Exception('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}