import 'dart:convert';
import 'package:health_tracker/model/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {

  static Future<List<Recipe>> getRecipe() async{
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "24", "start": "0"});

    final response = await http.get(uri, headers: {  
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "x-rapidapi-key": "f8c052f618msh77fe8d8e9411fecp1ab81ajsn37773b8491f5",
      "useQueryString": "true"
      });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for(var i in data['feed']){
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }

}