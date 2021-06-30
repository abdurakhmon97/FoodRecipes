import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavouritesScreen extends StatefulWidget {
  final List<Meal> list;
  FavouritesScreen(this.list);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();

}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.list.isEmpty
          ? Center(
              child: Text('Your favourites list is empty!'),
            )
          : ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              widget.list[index].id,
              widget.list[index].title,
              widget.list[index].imageUrl,
              widget.list[index].duration,
              widget.list[index].complexity,
              widget.list[index].affordability);
        },
        itemCount: widget.list.length,
      ));
  }
}
