import 'package:flutter/material.dart';

class MealPlanPage extends StatelessWidget {
  final Map<String, dynamic> breakfast;
  final Map<String, dynamic> lunch;
  final Map<String, dynamic> dinner;
  final int totalActualCalories;

  const MealPlanPage({
    Key? key,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.totalActualCalories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Plan'),
        backgroundColor: const Color(0xFFE8F4E8), // Background color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Breakfast
              _buildMealSection('Breakfast', breakfast),
              const SizedBox(height: 16),

              // Lunch
              _buildMealSection('Lunch', lunch),
              const SizedBox(height: 16),

              // Dinner
              _buildMealSection('Dinner', dinner),
              const SizedBox(height: 16),

              // Total Actual Calories
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4E8), // Background color for the total calories section
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Total Actual Calories: $totalActualCalories kcal',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealSection(String mealType, Map<String, dynamic> meal) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F4E8), // Background color for each meal section
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mealType,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Name: ${meal['name']}',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            'Calories: ${meal['calories']} kcal',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            'Fat: ${meal['fat']} g',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            'Protein: ${meal['protein']} g',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            'Carbohydrate: ${meal['carbohydrate']} g',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
