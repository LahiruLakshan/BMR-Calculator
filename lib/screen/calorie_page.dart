import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';
import 'meal_plan_page.dart';

class CaloriePage extends StatefulWidget {
  final String gender;
  final String age;
  final String height;
  final String weight;
  final String activityLevel;
  final String goal;
  final String dailyCalorieLimit;

  const CaloriePage({
    Key? key,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.goal,
    required this.dailyCalorieLimit,
  }) : super(key: key);

  @override
  _CaloriePageState createState() => _CaloriePageState();
}

class _CaloriePageState extends State<CaloriePage> {
  Future<void> _getMealPlan() async {
    final url = Uri.parse('${BASE_URL}meal-plan'); // Use the base URL from constants
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'total_calories': widget.dailyCalorieLimit}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealPlanPage(
            breakfast: data['breakfast'],
            lunch: data['lunch'],
            dinner: data['dinner'],
            totalActualCalories: data['total_actual_calories'],
          ),
        ),
      );
    } else {
      // Handle error
      print('Failed to load meal plan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Calorie Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Your calorie intake is
            const Text(
              'Your calorie intake is',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600, // Semi-bold
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // 2. Row with calorie text and icon
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.dailyCalorieLimit} kcal',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(width: 10),
                Image.asset('assets/images/burn_icon.png', width: 40, height: 40),
              ],
            ),
            const SizedBox(height: 20),

            // 3. Center custom image
            Center(
              child: Image.asset('assets/images/calorie_icon.png', width: 200, height: 200),
            ),
            const SizedBox(height: 20),

            // 4. Information text
            const Text(
              'Understanding your calorie intake helps you make informed choices for a balanced diet and healthier living.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300, // Light
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(), // Pushes the button to the bottom

            // 5. Next button with right arrow
            ElevatedButton(
              onPressed: _getMealPlan,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Border radius
                  side: const BorderSide(color: Colors.black), // Black border
                ),
                elevation: 0, // Remove shadow
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Next', style: TextStyle(color: Colors.black)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.black), // Arrow icon
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
