import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'calorie_page.dart';

class HealthPage extends StatefulWidget {
  final String gender;
  final String age;
  final String height;
  final String weight;
  final String activityLevel;
  final String activityDescription;

  const HealthPage({
    Key? key,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.activityDescription,
  }) : super(key: key);

  @override
  _HealthPageState createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  String selectedGoal = ''; // Track selected goal
  String selectedDiet = ''; // Track selected diet type

  Future<void> _sendDataAndNavigate() async {
    if (selectedGoal.isEmpty || selectedDiet.isEmpty) {
      // Show an alert if any field is not selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all fields.')),
      );
      return;
    }

    // Combine data for POST request
    final Map<String, dynamic> requestData = {
      'age': int.parse(widget.age),
      'weight': int.parse(widget.weight),
      'height': int.parse(widget.height),
      'gender': widget.gender.toLowerCase(),
      'activity_level': widget.activityLevel.toLowerCase(),
      'goal': selectedGoal.toLowerCase(),
    };

    print(requestData);

    // Send HTTP POST request
    final response = await http.post(
      Uri.parse('https://ec99-35-188-236-129.ngrok-free.app/calculate-calories'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final dailyCalorieLimit = responseData['daily_calorie_limit'];

      // Combine with previous data and navigate
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CaloriePage(
            age: widget.age,
            weight: widget.weight,
            height: widget.height,
            gender: widget.gender,
            activityLevel: widget.activityLevel,
            goal: selectedGoal,
            dailyCalorieLimit: dailyCalorieLimit.toString(),
          ),
        ),
      );
    } else {
      // Handle error response
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to calculate calories.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Progress Bar
            LinearProgressIndicator(
              value: 0.4, // 40% complete
              backgroundColor: Colors.grey[300],
              color: Colors.black,
              minHeight: 10,
            ),
            const SizedBox(height: 20),

            // 2. First Question Text
            const Text(
              "I want to _______ ,",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // 3. Goals Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SizedBox(
                height: 350, // Height for all buttons
                child: Column(
                  children: [
                    _buildGoalButton(title: "Weight maintenance"),
                    const SizedBox(height: 10),
                    _buildGoalButton(title: "Weight loss"),
                    const SizedBox(height: 10),
                    _buildGoalButton(title: "Muscle gain"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Second Question Text
            const Text(
              "I am a _______ ,",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // 5. Diet Type Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: selectedDiet == 'Vegetarian' ? Colors.green : Colors.white,
                      onPrimary: selectedDiet == 'Vegetarian' ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                        side: const BorderSide(color: Colors.black),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedDiet = 'Vegetarian';
                      });
                    },
                    child: const Text('Vegetarian'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: selectedDiet == 'Non-vegetarian' ? Colors.orange : Colors.white,
                      onPrimary: selectedDiet == 'Non-vegetarian' ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
                        side: const BorderSide(color: Colors.black),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedDiet = 'Non-vegetarian';
                      });
                    },
                    child: const Text('Non-vegetarian'),
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Proceed Button
            ElevatedButton(
              onPressed: _sendDataAndNavigate,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.black),
                ),
                elevation: 0,
              ),
              child: const Text('Proceed', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalButton({required String title}) {
    bool isSelected = selectedGoal == title;
    return SizedBox(
      width: double.infinity, // Make button width full width
      height: 70, // Set button height
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedGoal = title;
          });
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          primary: isSelected ? Colors.blue : Colors.white,
          onPrimary: isSelected ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black),
          ),
          elevation: 0,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

