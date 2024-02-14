import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/provider/favorites_provider.dart';
import 'package:meals/provider/meals_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(favoriteMealProvider);
    final bool isFavoriteMeal = meals.contains(meal);
    print(isFavoriteMeal);
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              onPressed: () {
                final wasAdded = ref
                    .read(favoriteMealProvider.notifier)
                    .toggleMealFavorite(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(wasAdded
                        ? "Meal added as favorite"
                        : "Meal removed from favorite"),
                  ),
                );
              },
              icon:
                  Icon(isFavoriteMeal ? Icons.favorite : Icons.favorite_border),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
              ),
              const SizedBox(
                height: 14,
              ),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              const Divider(
                thickness: 3,
                height: 24,
              ),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 28),
              ),
              const SizedBox(
                height: 14,
              ),
              for (final step in meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                )
            ],
          ),
        ));
  }
}
