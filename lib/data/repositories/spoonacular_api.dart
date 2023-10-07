import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:health_tracker/data/models/recipe_model.dart';
import 'package:health_tracker/data/repositories/api_keys.dart';
import 'package:http/http.dart' as http;

class SpoonacularService {
  SpoonacularService._instantiate();

  static final SpoonacularService instance = SpoonacularService._instantiate();

  final String _baseUrl = 'api.spoonacular.com';
  static const String _apiKey = APIKeys.spoonacular;

  // Generate Meal Plan
  Future<List<Recipe>> generateMealPlan({int? targetCalories, String? diet, String? timeFrame, String? exclude}) async {
    Map<String, String> parameters = {
      'timeFrame': timeFrame!,
      'targetCalories': targetCalories.toString(),
      'diet': diet!,
      'exclude': exclude!,
      'apiKey': _apiKey,
    };
    Uri uri = Uri.https(_baseUrl, '/mealplanner/generate', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    log(uri.toString());
    try {
      var response = await http.get(uri, headers: headers);
      List<dynamic> data = jsonDecode(response.body)['meals'];
      List<Recipe> recipes = [];
      if(response.body.isNotEmpty) {
        recipes = data.map((json) => Recipe.fromJson(json)).toList();
      } 
      return recipes;
      // return mealPlan;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Recipe>> getRandomRecipes({String? tags,required  int? number}) async {
    tags ??= '';

    Map<String, String> parameters = {
      'limitedLicense': 'true',
      'tags': tags,
      'number': number.toString(),
      'apiKey': _apiKey,
    };
    Uri uri = Uri.https(_baseUrl, '/recipes/random', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    log(uri.toString());
    // ! remove this ^

    try {
      var response = await http.get(uri, headers: headers);
      List<dynamic> data = jsonDecode(response.body)['recipes'];
      List<Recipe> recipes = [];
      if(response.body.isNotEmpty) {
        recipes = data.map((json) => Recipe.fromJson(json)).toList();
      } 
      return recipes;
      // final recipes = json.decode(response.body)['recipes'].map((e) => Recipe.fromJson(e)).toList();
      // final recipes = jsonDecode(response.body).cast<Map<String, dynamic>>();
      // recipes.map<Recipe>((json) => Recipe.fromJson(json)).toList();
      // Recipe recipe = Recipe.fromMap(data);
      // log('HERE IS THE RECIPE ====> \n' + recipes.toString());
      // return recipes;
    } catch (e) {
      log(e.toString());
      throw 'I AM HERE ==> $e';
    }
  }

  Future<Recipe> fetchRecipe(String id) async {
    Map<String, String> parameters = {'includeNutrition': 'false'};
    Uri uri = Uri.https(_baseUrl, 'recipes/$id/information', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      Recipe recipe = Recipe.fromJson(data);
      return recipe;
    } catch (e) {
      throw e.toString();
    }
  }
}
