import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset("assets/fooderlich_assets/empty_list.png"),
            ),
          ),
          Text("No Groceries", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          const Text(
            "Shopping for ingredients?\n"
            "Tap the + button to add them.",
            textAlign: TextAlign.center,
          ),
          MaterialButton(
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Colors.green,
            onPressed: () {
              context.goNamed(
                'home',
                params: {'tab': '${FooderlichTab.recipes}'},
              );
            },
            child: const Text("Browse Recipes"),
          ),
        ],
      ),
    );
  }
}
