import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/screens/categories_Screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tab_screen.dart';

import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favouriteMeals = [];

  void _toggleFavourites(String mealId) {
    final existingIndex = favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0)
      favouriteMeals.removeAt(existingIndex);
    else
        favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      availableMeals = DUMMY_MEALS.where((meal){
        if(_filters['gluten'] && !meal.isGlutenFree)
          return false;
        if(_filters['lactose'] && !meal.isLactoseFree)
          return false;
        if(_filters['vegan'] && !meal.isVegan)
          return false;
        if(_filters['vegetarian'] && !meal.isVegetarian)
          return false;
        return true;
      }).toList();
    });
  }

  bool isFavMeal(String id) {
    return favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deli meals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                body2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              )),
      home: TabScreen(favouriteMeals),
      routes: {
        '/category-meal': (ctx) => CategoryMealsScreen(availableMeals),
        '/meal-detail': (ctx) => MealDetailScreen(_toggleFavourites, isFavMeal),
        '/filters-screen': (ctx) => FiltersScreen(_filters, _setFilters),
      },
    );
  }
}
