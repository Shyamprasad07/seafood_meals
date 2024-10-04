import 'package:dio/dio.dart';

class ApiService {
  final String baseUrl =
      "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood";
  final Dio dio = Dio();

  Future<List<dynamic>> fetchMeals() async {
    try {
      final response = await dio.get(baseUrl);

      if (response.statusCode == 200) {
        if (response.data['meals'] != null) {
          return response.data['meals'];
        } else {
          print("No meals found in the response.");
          return [];
        }
      } else {
        print("Error: Received status code ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("API request error: $e");
      return [];
    }
  }
}
