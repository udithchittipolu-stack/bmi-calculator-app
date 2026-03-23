import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const BMIScreen(),
    );
  }
}

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {

  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();


  double? bmi;
  String? category = "";
  String gender = "Male";

  void calculateBMI() {
    double height = double.parse(heightController.text) / 100;
    double weight = double.parse(weightController.text);

    setState(() {
      bmi = weight / pow(height, 2);
    });

    if (bmi! < 18.5) {
      category = "Underweight";
    } else if (bmi! >= 18.5 && bmi! < 24.9) {
      category = "Normal";
    } else if (bmi! >= 25 && bmi! < 29.9) {
      category = "Overweight";
    } else {
      category = "obese";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'BMICalculatorApp',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A0DAD), Color(0XFF9B59B6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter your Details',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20,),
            _buildGenderToggle(),

            const SizedBox(height: 20,),
            _buildInputFields(
                controller: heightController,
                label: "Height (cm)",
                icon: Icons.height
            ),
            const SizedBox(height: 20,),
            _buildInputFields(
                controller: weightController,
                label: "Weight (kg)",
                icon: Icons.height
            ),

            const SizedBox(height: 30,),

            ElevatedButton(
              onPressed: calculateBMI,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xff8e48ad),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8

              ),

              child: const Text("Calculate BMI", style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              ),),


            const SizedBox(height: 30,),
            if(bmi != null) _buildResultCard()

          ],
        ),
      ),
    );
  }


  Widget _buildGenderToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGenderButton(
            "Male",
            Icons.male,
            gender == "Male"),
        const SizedBox(width: 20,),
        _buildGenderButton(
            "Female",
            Icons.female,
            gender == "Female"),
      ],
    );
  }

  Widget _buildGenderButton(String label, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          gender = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(microseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
            const BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ]
              : [],
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.deepPurple : Colors.white),
            const SizedBox(width: 10),

            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.deepPurple : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildInputFields({
    required TextEditingController controller,
    required String label,
    required IconData icon,

  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          prefixIcon: Icon(icon, color: Colors.white,),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15)

          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.purpleAccent),
            borderRadius: BorderRadius.circular(15),

          )
      ),

    );
  }

  Widget _buildResultCard() {
    return Card(
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Your BMI: ${bmi!.toStringAsFixed(2)}",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),

            ),
            const SizedBox(height: 10,),
            Text(
              "Category: $category",
              style:  TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: bmi! < 18.5 ? Colors.orange : bmi! < 29.9 ? Colors.green : (bmi! < 29.9 ? Colors.orange : Colors.red)),

            ),
            const SizedBox(
              height: 10,
            ),

            Text(
              "Gender: $gender",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),

            ),


          ],
        ),
      ),
    );
  }


}
