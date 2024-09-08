import 'package:bmr_calculator/screen/calorie_page.dart';
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
  final String calorie;

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
    required this.calorie,
  }) : super(key: key);

  @override
  _FoodWishPageState createState() => _FoodWishPageState();
}

class _FoodWishPageState extends State<FoodWishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Food Wish Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display Progress Bar
              LinearProgressIndicator(
                value: 0.7, // 70% complete
                backgroundColor: Colors.grey[300],
                color: Colors.black,
                minHeight: 10,
              ),
              const SizedBox(height: 20),

              // Question Text
              const Text(
                "Which foods you wish to include and normally have?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 20),

              // Carbs Section
              const Text(
                "Carbs",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 10),
              _buildGrid([
                {"title": "Rice", "icon": "assets/images/img.png"},
                {"title": "Beans", "icon": "assets/images/img_1.png"},
                {"title": "Oats", "icon": "assets/images/img_2.png"},
                {"title": "Bread", "icon": "assets/images/img_3.png"},
                {"title": "Potato", "icon": "assets/images/img_4.png"},
                {"title": "Corn", "icon": "assets/images/img_5.png"},
                {"title": "Pasta", "icon": "assets/images/img_6.png"},
                {"title": "Popcorn", "icon": "assets/images/img_7.png"},
              ]),

              const SizedBox(height: 20),

              // Protein Section
              const Text(
                "Protein",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 10),
              _buildGrid([
                {"title": "Egg", "icon": "assets/images/img_8.png"},
                {"title": "Chicken", "icon": "assets/images/img_9.png"},
                {"title": "Fish", "icon": "assets/images/img_10.png"},
                {"title": "Pork", "icon": "assets/images/img_11.png"},
                {"title": "Beef", "icon": "assets/images/img_12.png"},
                {"title": "Tofu", "icon": "assets/images/img_13.png"},
                {"title": "Tuna", "icon": "assets/images/img_14.png"},
                {"title": "Ham", "icon": "assets/images/img_15.png"},
              ]),

              const SizedBox(height: 20),

              // Fat Section
              const Text(
                "Fat",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 10),
              _buildGrid([
                {"title": "Chocolate", "icon": "assets/images/img_16.png"},
                {"title": "Avocado", "icon": "assets/images/img_17.png"},
                {"title": "Peanuts", "icon": "assets/images/img_18.png"},
              ], isThreeRow: true),

              const SizedBox(height: 30),

              // Proceed Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CaloriePage(
                          gender: widget.gender,
                          age: widget.age,
                          height: widget.height,
                          weight: widget.weight,
                          activityLevel: widget.activityLevel,
                          goal: widget.goal,
                          dailyCalorieLimit: widget.calorie,
                        ),
                      ),
                    );
                  },
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List<Map<String, String>> items, {bool isThreeRow = false}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length + (isThreeRow ? 0 : 1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        if (index >= items.length) return const SizedBox(); // Empty last grid
        final item = items[index];
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(item["title"]!, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: 30,  // Set image width
                    height: 50, // Set image height
                    child: Image.asset(
                      item["icon"]!,
                      fit: BoxFit.contain, // Adjust fit if needed
                    ),
                  ),

                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
