import 'package:flutter/material.dart';

import 'health_page.dart';

class PhysicalActivityPage extends StatefulWidget {
  final String gender;
  final String age;
  final String height;
  final String weight;

  const PhysicalActivityPage({
    Key? key,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
  }) : super(key: key);

  @override
  State<PhysicalActivityPage> createState() => _PhysicalActivityPageState();
}

class _PhysicalActivityPageState extends State<PhysicalActivityPage> {
  String selectedActivityLevel = ''; // Track selected activity level
  String selectedActivityDescription = ''; // Track selected activity description

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physical Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Progress Bar
            LinearProgressIndicator(
              value: 0.2, // 20% complete
              backgroundColor: Colors.grey[300],
              color: Colors.black,
              minHeight: 10,
            ),
            const SizedBox(height: 20),

            // 2. Question Text
            const Text(
              "What is your physical activity level?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // 3. Activity Level Buttons
            Expanded(
              child: ListView(
                children: [
                  _buildActivityButton(
                    title: 'Sedentary',
                    subTitle: 'No or little exercise',
                  ),
                  const SizedBox(height: 10),
                  _buildActivityButton(
                    title: 'Lightly active',
                    subTitle: 'Exercise 2-3 days per week',
                  ),
                  const SizedBox(height: 10),
                  _buildActivityButton(
                    title: 'Moderately active',
                    subTitle: 'Exercise 4-5 days per week',
                  ),
                  const SizedBox(height: 10),
                  _buildActivityButton(
                    title: 'Very active',
                    subTitle: 'Exercise 6-7 days per week',
                  ),
                  const SizedBox(height: 10),
                  _buildActivityButton(
                    title: 'Extra active',
                    subTitle: 'Very hard exercise/sports & physical job',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityButton({required String title, required String subTitle}) {
    bool isSelected = selectedActivityLevel == title;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedActivityLevel = title;
          selectedActivityDescription = subTitle; // Save the description
        });

        // Navigate to the HealthPage with all the collected data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HealthPage(
              gender: widget.gender,
              age: widget.age,
              height: widget.height,
              weight: widget.weight,
              activityLevel: selectedActivityLevel,
              activityDescription: selectedActivityDescription,
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        primary: isSelected ? Colors.blue : Colors.white,
        onPrimary: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.black),
        ),
        elevation: 0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subTitle,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}