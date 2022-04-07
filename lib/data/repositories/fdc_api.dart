import 'package:http/http.dart' as http;

class FoodDataCentralService {
  FoodDataCentralService._instantiate();

  static final  FoodDataCentralService instance = FoodDataCentralService._instantiate();

  final String _baseUrl = 'api.nal.usda.gov/fdc/v1';
  static const String _apiKey = 'gkWkb1cAcwybUkTpxX7RIBfadCfVigZQM7WUFPr2';
}