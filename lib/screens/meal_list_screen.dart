import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/meal_api.dart';

class MealListScreen extends StatefulWidget {
  final String category;
  const MealListScreen({super.key, required this.category});

  @override
  State<MealListScreen> createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  final MealApi _api = MealApi();
  List<Meal> _meals = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  Future<void> _loadMeals() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final meals = await _api.fetchMealsByCategory(widget.category);
      setState(() {
        _meals = meals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Could not load meals. Check your internet connection.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_isLoading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      body = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _loadMeals, child: const Text('Retry')),
          ],
        ),
      );
    } else {
      body = ListView.builder(
        itemCount: _meals.length,
        itemBuilder: (context, index) {
          final meal = _meals[index];
          return ListTile(
            leading: Image.network(meal.imageUrl, width: 56, height: 56),
            title: Text(meal.name),
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: body,
    );
  }
}