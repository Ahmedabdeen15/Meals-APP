import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/favorites_provider.dart';
import 'package:meals/provider/filters_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filter.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectedPageUpdate(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String id) async {
    Navigator.of(context).pop();
    if (id == 'filters') {
      Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeal = ref.watch(filteredMealProvider);
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeal,
    );
    var activeScreenTitle = 'Pick your category';
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealProvider);
      activePage = MealScreen(
        meals: favoriteMeals,
      );
      activeScreenTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
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
