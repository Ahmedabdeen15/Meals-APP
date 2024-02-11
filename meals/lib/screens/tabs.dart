import 'package:flutter/material.dart';
import 'package:meals/categories.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeal = [];

  void _showInMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeal.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeal.remove(meal);
        _showInMessage('Meal has been remove form your favorite');
      });
    } else {
      setState(() {
        _favoriteMeal.add(meal);
        _showInMessage('Meal is added form your favorite');
      });
    }
  }

  void _selectedPageUpdate(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activeScreenTitle = 'Pick your category';
    if (_selectedPageIndex == 1) {
      activePage = MealScreen(
        meals: _favoriteMeal,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activeScreenTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedPageUpdate,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ]),
    );
  }
}
