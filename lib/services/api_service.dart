import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:3000/api"; // Your backend URL

  // Fetch product list
  static Future<List<dynamic>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Upload an image
  static Future<String> uploadImage(String filePath) async {
    var request = http.MultipartRequest(
      'POST', Uri.parse('http://localhost:3000/upload')
    );
    
    request.files.add(await http.MultipartFile.fromPath('image', filePath));
    var response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = await response.stream.bytesToString();
      return json.decode(jsonResponse)['imageUrl'];
    } else {
      throw Exception('Failed to upload image');
    }
  }

  // Add item to cart
  static Future<void> addToCart(String userId, String productId, int quantity) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cart/$userId'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"productId": productId, "quantity": quantity}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add to cart');
    }
  }
}
