import 'package:flutter/material.dart';
import 'package:fooderlich/screens/today_recipe_list_view.dart';
import "../components/components.dart";
import "../models/models.dart";
import '../api/mock_fooderlich_service.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});
  final mockService = MockFooderlichService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final recipes = snapshot.data?.todayRecipes ?? [];
          return ListView(
            scrollDirection: Axis.vertical,
            children: [
              TodayRecipeListView(recipes),
              const SizedBox(height: 16),
             FriendPostListView(friendPosts: snapshot.data?.friendPosts ?? []),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
