import 'package:flutter/material.dart';
import 'physical_activity_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedGender = 'Male'; // To manage gender selection
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  String? age;
  String? height;
  String? weight;

  // Function to validate the inputs
  bool validateInputs() {
    if (ageController.text.isEmpty || heightController.text.isEmpty || weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required')),
      );
      return false;
    }

    try {
      int.parse(ageController.text); // Validate age is an integer
      double.parse(heightController.text); // Validate height is a number
      double.parse(weightController.text); // Validate weight is a number
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid numbers')),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1st Row - Gender Selection
            Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset('assets/images/person.png'), // Custom PNG
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: selectedGender == 'Male' ? Colors.blue : Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                              side: BorderSide(color: Colors.black),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedGender = 'Male';
                            });
                          },
                          child: const Text('Male', style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: selectedGender == 'Female' ? Colors.pink : Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
                              side: BorderSide(color: Colors.black),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedGender = 'Female';
                            });
                          },
                          child: const Text('Female', style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 2nd Row - Age Input
            Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset('assets/images/calendar.png'), // Custom PNG
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                const Text('Years'),
              ],
            ),
            const SizedBox(height: 16),

            // 3rd Row - Height Input
            Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset('assets/images/height.png'), // Custom PNG
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: heightController,
                    decoration: const InputDecoration(labelText: 'Height'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                const Text('cm'),
              ],
            ),
            const SizedBox(height: 16),

            // 4th Row - Weight Input
            Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset('assets/images/weight.png'), // Custom PNG
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: weightController,
                    decoration: const InputDecoration(labelText: 'Weight'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                const Text('kg'),
              ],
            ),
            const Spacer(),

            // Bottom Next Button with arrow icon
            ElevatedButton(
              onPressed: () {
                if (validateInputs()) {
                  // Save values in the state
                  setState(() {
                    age = ageController.text;
                    height = heightController.text;
                    weight = weightController.text;
                  });

                  // Navigate to PhysicalActivityPage and pass the values
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhysicalActivityPage(
                        gender: selectedGender,
                        age: age!,
                        height: height!,
                        weight: weight!,
                      ),
                    ),
                  );
                }
              },
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

