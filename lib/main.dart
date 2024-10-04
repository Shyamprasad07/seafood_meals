import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dependency_injection.dart';
import 'views/meal_view.dart';

void main() {
  DependencyInjection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seafood Meals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MealView(),
    );
  }
}
