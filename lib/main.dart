import 'package:flutter/material.dart';
import 'package:flutter_meal_app/model/dummy_data.dart';
import 'package:flutter_meal_app/model/meal.dart';
import 'package:flutter_meal_app/screen/FiltersScreen.dart';
import 'package:flutter_meal_app/screen/cartegory_meals_screen.dart';
import 'package:flutter_meal_app/screen/categories_screen.dart';
import 'package:flutter_meal_app/screen/meal_detail_screen.dart';
import 'package:flutter_meal_app/screen/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(
      () {
        _filters = filterData;
        _availableMeals = DUMMY_MEALS.where((meal) {
          if (_filters['gluten']! && !meal.isGlutenFree) {
            return false;
          }
          if (_filters['lactose']! && !meal.isLactoseFree) {
            return false;
          }
          if (_filters['vegan']! && !meal.isVegan) {
            return false;
          }
          if (_filters['vegetarian']! && !meal.isVegetarian) {
            return false;
          }
          return true;
        }).toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routName: (context) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(saveFilters: _setFilters, currentFilters: _filters),
      },
      title: 'meal',
      // home: MyHomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Meals Category'),
//       ),
//       body: CategoriesScreen(),
//     );
//   }
// }
