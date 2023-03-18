import 'package:flutter/material.dart';

class Card1 extends StatelessWidget {
  const Card1({super.key});

  final category = "Editor's Choice";
  final title = 'The Art of Dough';
  final description = 'Learn to make the perfect dough';
  final chef = 'Mike Katz';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints.expand(width: 350, height: 450),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/mag1.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Stack(
          children: [
            Text(category, style: Theme.of(context).textTheme.bodyLarge),
            Positioned(
              top: 20,
              child:
                  Text(title, style: Theme.of(context).textTheme.headlineSmall),
            ),
            Positioned(
              bottom: 30,
              right: 0,
              child: Text(description,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              child: Text(chef, style: Theme.of(context).textTheme.bodyLarge),
            ),
          ],
        ),
      ),
    );
  }
}
