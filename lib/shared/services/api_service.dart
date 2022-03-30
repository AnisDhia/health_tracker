import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:health_tracker/data/models/meal_plan_model.dart';
import 'package:health_tracker/data/models/recipe_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'api.spoonacular.com';
  static const String _API_KEY = '73071387df1246538cb0d2678f85ec94';

  // Generate Meal Plan
  Future<MealPlan> generateMealPlan({int? targetCalories, String? diet}) async {
    if (diet == 'None') diet = '';
    Map<String, String> parameters = {
      'timeFrame': 'day',
      'targetCalories': targetCalories.toString(),
      'diet': diet!,
      'apiKey': _API_KEY,
    };
    Uri uri = Uri.https(_baseUrl, '/recipes/mealplanner/generate', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      MealPlan mealPlan = MealPlan.fromMap(data);
      return mealPlan;
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
      'apiKey': _API_KEY,
    };
    Uri uri = Uri.https(_baseUrl, '/recipes/random', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    log(uri.toString());

    try {
      var response = await http.get(uri, headers: headers);
      List<dynamic> data = jsonDecode(response.body)['recipes'];
      List<Recipe> recipes = [];
      if(response.body != null) {
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
      throw 'POOP ==> '  + e.toString();
    }
  }

  Future<Recipe> fetchRecipe(String id) async {
    Map<String, String> parameters = {'includeNutrition': 'false'};
    Uri uri = Uri.https(_baseUrl, 'recipes/$id/information', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'applicatoin/json',
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
