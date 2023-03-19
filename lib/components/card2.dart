import 'package:flutter/material.dart';
import 'package:fooderlich/components/author_card.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/models/models.dart';

class Card2 extends StatelessWidget {
  const Card2({super.key, required this.recipe});
  final ExploreRecipe recipe;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(recipe.backgroundImage),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          children: [
             AuthorCard(
              authorName: recipe.authorName,
               title: recipe.role,
              imageProvider: AssetImage(recipe.profileImage),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 70,
                    left: 16,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(recipe.title,
                          style: FooderlichTheme.lightTextTheme.displayLarge),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Text(recipe.subtitle,
                        style: FooderlichTheme.lightTextTheme.displayLarge),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
