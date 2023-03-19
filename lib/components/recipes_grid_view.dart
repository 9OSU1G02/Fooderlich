import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fooderlich/components/recipe_thumbnail.dart';
import '../models/models.dart';

class RecipesGridView extends StatefulWidget {
  const RecipesGridView({super.key, required this.recipes});
  final List<SimpleRecipe> recipes;

  @override
  State<RecipesGridView> createState() => _RecipesGridViewState();
}

class _RecipesGridViewState extends State<RecipesGridView> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels <=
          _scrollController.position.minScrollExtent) {
        print('At top of list');
      } else if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        print('At bottom of list');
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate:
            //const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 397.0, childAspectRatio: 1.0),
        itemBuilder: ((context, index) {
          final recipe = widget.recipes[index];
          return RecipeThumbnail(recipe: recipe);
        }),
        itemCount: widget.recipes.length,
      ),
    );
  }
}
