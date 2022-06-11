import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:health_tracker/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class OpenFoodFactsAPI {
  OpenFoodFactsAPI._instantiate();

  static final OpenFoodFactsAPI instance = OpenFoodFactsAPI._instantiate();

  final String _baseUrl = 'world.openfoodfacts.org';

  Future<Product> fetchProductByUPC(String upc) async {
    Map<String, String> parameters = {};
    Uri uri = Uri.https(_baseUrl, '/api/v0/product/$upc.json', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    log(uri.toString());
    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      return Product.fromJson(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
