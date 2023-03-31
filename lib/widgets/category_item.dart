import 'package:flutter/material.dart';
import 'package:flutter_meal_app/screen/cartegory_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final String id;

  CategoryItem({required this.id, required this.title, required this.color});
  //
  void popCatgoryMeals(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routName,
      arguments: {
        'id': id as String,
        'title': title as String,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => popCatgoryMeals(context),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
