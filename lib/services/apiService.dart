import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey = '72fffca7af6645d0975f0f50769eabb0';
  static const String _baseUrl = 'https://api.spoonacular.com/food/ingredients';

  //Método para buscar productos por nombre
  Future<List<dynamic>> getProducts(String query) async {
    final url = Uri.parse('$_baseUrl/search?query=$query&apiKey=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Error al buscar productos: ${response.statusCode}');
    }
  }

  //Método para obtener los detalles de un producto según su id
  Future<Map<String, dynamic>> getProductDetails(int id) async {
    final url = Uri.parse('$_baseUrl/$id/information?amount=1&apiKey=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Error al obtener detalles del producto: ${response.statusCode}');
    }
  }
}
