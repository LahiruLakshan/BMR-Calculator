import 'package:flutter/material.dart';

class FoodWishPage extends StatefulWidget {
  final String gender;
  final String age;
  final String height;
  final String weight;
  final String activityLevel;
  final String activityDescription;
  final String goal;
  final String diet;

  const FoodWishPage({
    Key? key,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.activityDescription,
    required this.goal,
    required this.diet,
  }) : super(key: key);

  @override
  _FoodWishPageState createState() => _FoodWishPageState();
}

class _FoodWishPageState extends State<FoodWishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Wish Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Progress Bar
            LinearProgressIndicator(
              value: 1.0, // 100% complete
              backgroundColor: Colors.grey[300],
              color: Colors.black,
              minHeight: 10,
            ),
            const SizedBox(height: 20),

            // Display Collected Data
            Text(
              'Here are the details you have provided:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            _buildDetailRow('Gender:', widget.gender),
            _buildDetailRow('Age:', widget.age),
            _buildDetailRow('Height:', widget.height),
            _buildDetailRow('Weight:', widget.weight),
            _buildDetailRow('Activity Level:', widget.activityLevel),
            _buildDetailRow('Activity Description:', widget.activityDescription),
            _buildDetailRow('Goal:', widget.goal),
            _buildDetailRow('Diet:', widget.diet),

            const Spacer(),

            // Button to finalize or proceed further
            ElevatedButton(
              onPressed: () {
                // Handle final action
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.black),
                ),
                elevation: 0,
              ),
              child: const Text('Finish', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
          Text(value, style: const TextStyle(color: Colors.brown)),
        ],
      ),
    );
  }
}
