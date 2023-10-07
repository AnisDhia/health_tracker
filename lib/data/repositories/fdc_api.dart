import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:health_tracker/data/models/food_model.dart';
import 'package:health_tracker/data/repositories/api_keys.dart';
import 'package:http/http.dart' as http;

class FoodDataCentralService {
  FoodDataCentralService._instantiate();

  static final FoodDataCentralService instance =
      FoodDataCentralService._instantiate();

  final String _baseUrl = 'api.nal.usda.gov';
  static const String _apiKey = APIKeys.fdc;

  Future<List<Food>> searchFood(String query) async {
    if (query.isEmpty) {
      return [];
    }
    Map<String, String> parameters = {
      'api_key': _apiKey,
      'query': query,
    };
    Uri uri = Uri.https(_baseUrl, '/fdc/v1/foods/search', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      List<dynamic> data = jsonDecode(response.body)['foods'];
      List<Food> foods = [];
      if (response.body.isNotEmpty) {
        foods = data.map((json) => Food.fromJson(json)).toList();
      }
      return foods;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Food> fetchFoodByID(String fdcId) async {
    Map<String, String> parameters = {
      'api_key': _apiKey,
    };
    Uri uri = Uri.https(_baseUrl, '/fdc/v1/food/$fdcId', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = jsonDecode(response.body);
      return Food.fromJson(data);
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }
}
