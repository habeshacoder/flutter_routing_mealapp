import 'package:flutter/material.dart';
import 'package:flutter_meal_app/model/dummy_data.dart';
import 'package:flutter_meal_app/model/meal.dart';
import 'package:flutter_meal_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static final routName = '/CategoryMealsScreen';
  List<Meal> availableMeals;
  CategoryMealsScreen({
    required this.availableMeals,
  });

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  var meals;
  var argValue;
  bool isloaded = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!isloaded) {
      argValue = ModalRoute.of(context)!.settings.arguments as Map;
      meals = widget.availableMeals.where((meal) {
        return meal.categories.contains(argValue['id']);
      }).toList();
    }
    isloaded = true;

    super.didChangeDependencies();
  }

  void removeItem(var mealId) {
    setState(() {
      meals.removeWhere(
        (meal) {
          return meal.id == mealId;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          argValue['title'],
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => MealItem(
          // removeItem: removeItem,
          id: meals[index].id,
          title: meals[index].title,
          imageUrl: meals[index].imageUrl,
          affordability: meals[index].affordability,
          complexity: meals[index].complexity,
          duration: meals[index].duration,
        ),
        itemCount: meals.length,
      ),
    );
  }
}
