import 'package:flutter/material.dart';
import 'package:fooderlich/components/recipes_grid_view.dart';
import '../api/mock_fooderlich_service.dart';

class RecipesScreen extends StatelessWidget {
  RecipesScreen({super.key});
  final exploreService = MockFooderlichService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final recipes = snapshot.data ?? [];
            return RecipesGridView(recipes: recipes);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
        future: exploreService.getRecipes());
  }
}
