import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  final String baseUrl = "https://crud.teamrabbil.com/api/v1/";

  // Get all products
  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/ReadProduct'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = json.decode(response.body);

        if (decodedResponse.containsKey('data')) {
          final List<dynamic> productList = decodedResponse['data'];
          return productList.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception("No 'data' field found in response");
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching products: $e');
    }
  }

  // Create a new product
  Future<void> createProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/CreateProduct'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to create product');
      }
    } catch (e) {
      throw Exception('Error occurred while creating product: $e');
    }
  }

  // Update an existing product
  Future<void> updateProduct(String id, Product product) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/UpdateProduct/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      throw Exception('Error occurred while updating product: $e');
    }
  }

  // Delete a product
  Future<void> deleteProduct(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/DeleteProduct/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      throw Exception('Error occurred while deleting product: $e');
    }
  }
}
