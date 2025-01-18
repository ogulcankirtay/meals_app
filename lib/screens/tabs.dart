import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:meals_app/providers/favorites_provider.dart";
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/filters_provider.dart';

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  ConsumerState<Tabs> createState() => _TabsState();
}

class _TabsState extends ConsumerState<Tabs> {
  int selectedPageIndex = 0;

  void selectScreen(String identifier) async {
    if (identifier == "Meals") {
      Navigator.of(context).pop();
    } else if (identifier == "Filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (context) => const Filters()));
    }
  }

  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);
    var activePageTitle = "Categories";
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );

    if (selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: selectScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPageIndex,
          onTap: selectPage,
          selectedItemColor: Colors.lime,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.star_rounded), label: "Favorites"),
          ]),
    );
  }
}
