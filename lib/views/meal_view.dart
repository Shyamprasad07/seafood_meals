import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/controllers/meals_controller.dart';

class MealView extends StatelessWidget {
  final MealController mealController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seafood Meals'),
      ),
      body: Obx(() {
        if (mealController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (mealController.meals.isEmpty) {
          return const Center(child: Text('No Meals Available.'));
        } else {
          return ListView.builder(
          padding: const EdgeInsets.only(bottom: 16.0,left: 8,right: 8),
            itemCount: mealController.meals.length,
            itemBuilder: (context, index) {
              final meal = mealController.meals[index];
              return Container(
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      child: CachedNetworkImage(
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        imageUrl: meal.strMealThumb,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 0.6,
                            color: Colors.red,
                          ),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/logo.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        meal.strMeal,maxLines: 3,
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
