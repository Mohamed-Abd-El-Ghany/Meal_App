import 'package:flutter/material.dart';

// import 'package:mealapp/screens/tabs_screen.dart';
// import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  });
  final Map<Filter, bool> currentFilters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeFilter = false;
  bool _lactoseFreeFilter = false;
  bool _veganFilter = false;
  bool _vegetarianFilter = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilter = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilter = widget.currentFilters[Filter.lactoseFree]!;
    _veganFilter = widget.currentFilters[Filter.vegan]!;
    _vegetarianFilter = widget.currentFilters[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilter,
            Filter.lactoseFree: _lactoseFreeFilter,
            Filter.vegan: _veganFilter,
            Filter.vegetarian: _vegetarianFilter,
          });
          return false;
        },
        child: Column(
          children: [
            customSwitch(
              context,
              "Gluten-free",
              'Only include gluten-free meals.',
              _glutenFreeFilter,
              (bool value) => setState(() => _glutenFreeFilter = value),
            ),
            customSwitch(
              context,
              "Lactose-free",
              'Only include lactose-free meals.',
              _lactoseFreeFilter,
              (bool value) => setState(() => _lactoseFreeFilter = value),
            ),
            customSwitch(
              context,
              "Vegan",
              'Only include vegan meals.',
              _veganFilter,
              (bool value) => setState(() => _veganFilter = value),
            ),
            customSwitch(
              context,
              "Vegetarian",
              'Only include vegetarian meals.',
              _vegetarianFilter,
              (bool value) => setState(() => _vegetarianFilter = value),
            ),
          ],
        ),
      ),
    );
  }

  SwitchListTile customSwitch(
    BuildContext context,
    String title,
    String subtitle,
    bool filter,
    Function(bool newValue) onChanged,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      activeColor: Theme.of(context).colorScheme.onBackground,
      contentPadding: const EdgeInsets.only(left: 35, right: 25),
      value: filter,
      onChanged: onChanged,
    );
  }
}
