import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/meal_model.dart';
import '../services/api_service.dart';
import '../services/db_service.dart';

class MealController extends GetxController {
  var isLoading = true.obs;
  var meals = <Meal>[].obs;
  final ApiService apiService = ApiService();
  final DbService dbService = DbService();

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      loadMealsFromDB();
    } else {
      fetchMeals();
    }
  }

  Future<void> fetchMeals() async {
    isLoading(true);
    try {
      var mealList = await apiService.fetchMeals();
      meals.assignAll(mealList.map((json) => Meal.fromJson(json)).toList());
      dbService.saveMeals(meals.map((meal) => meal.toJson()).toList());
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadMealsFromDB() async {
    isLoading(true);
    try {
      var mealList = await dbService.getMeals();
      if (mealList.isEmpty) {
        Get.snackbar('No Internet', 'Connect to the internet to fetch meals');
      } else {
        meals.assignAll(mealList.map((json) => Meal.fromJson(json)).toList());
      }
    } finally {
      isLoading(false);
    }
  }
}
