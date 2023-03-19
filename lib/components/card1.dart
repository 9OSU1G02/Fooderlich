import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';

class Card1 extends StatelessWidget {
  const Card1({super.key, required this.recipe});
  final ExploreRecipe recipe;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints.expand(width: 350, height: 450),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(recipe.backgroundImage),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Stack(
          children: [
            Text(recipe.subtitle, style: Theme.of(context).textTheme.bodyLarge),
            Positioned(
              top: 20,
              child: Text(recipe.title,
                  style: Theme.of(context).textTheme.displayMedium),
            ),
            Positioned(
              bottom: 30,
              right: 0,
              child: Text(recipe.message,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              child: Text(recipe.authorName,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          ],
        ),
      ),
    );
  }
}
