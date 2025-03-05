import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.deepPurple,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 20),
          bodyMedium: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  double height = 170;
  double weight = 70;
  double bmi = 0;
  bool isCalculated = false;

  void calculateBMI() {
    setState(() {
      bmi = weight / ((height / 100) * (height / 100));
      isCalculated = true;
    });
  }

  void resetValues() {
    setState(() {
      isCalculated = false;
      bmi = 0;
    });
  }

  String determineCategory() {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi <= 24.9) {
      return 'Normal Weight';
    } else if (bmi <= 29.9) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }

  Color categoryTextColor() {
    if (bmi < 18.5) {
      return Colors.blue;
    } else if (bmi <= 24.9) {
      return Colors.green;
    } else if (bmi <= 29.9) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  double weightToLose() {
    double normalMaxWeight = 24.9 * ((height / 100) * (height / 100));
    return weight - normalMaxWeight > 0 ? weight - normalMaxWeight : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(minimum: 10, maximum: 40, ranges: <GaugeRange>[
                  GaugeRange(startValue: 10, endValue: 18.5, color: Colors.blue),
                  GaugeRange(startValue: 18.5, endValue: 24.9, color: Colors.green),
                  GaugeRange(startValue: 25, endValue: 29.9, color: Colors.orange),
                  GaugeRange(startValue: 30, endValue: 40, color: Colors.red),
                ],
                    pointers: <GaugePointer>[NeedlePointer(value: bmi)],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          bmi.toStringAsFixed(2),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        angle: 90,
                        positionFactor: 0.5,
                      )
                    ]
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Height: ${height.toStringAsFixed(1)} cm', style: Theme.of(context).textTheme.bodyLarge),
            Slider(
              value: height,
              min: 100,
              max: 220,
              activeColor: Colors.deepPurpleAccent,
              onChanged: (value) {
                setState(() {
                  height = value;
                  resetValues();
                });
              },
            ),
            const SizedBox(height: 20),
            Text('Weight: ${weight.toStringAsFixed(1)} kg', style: Theme.of(context).textTheme.bodyLarge),
            Slider(
              value: weight,
              min: 30,
              max: 150,
              activeColor: Colors.deepPurpleAccent,
              onChanged: (value) {
                setState(() {
                  weight = value;
                  resetValues();
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: calculateBMI,
              child: const Text('Calculate BMI', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            if (isCalculated)
              Column(
                children: [
                  Text(
                    'Your BMI: ${bmi.toStringAsFixed(1)}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    determineCategory(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold, color: categoryTextColor()),
                    textAlign: TextAlign.center,
                  ),
                  if (bmi < 18.5) // Underweight Message
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue, // Same as Underweight Font color
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'You need to gain ${(18.5 * ((height / 100) * (height / 100)) - weight).toStringAsFixed(1)} kg to reach normal BMI',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  if (weightToLose() > 0)
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'You need to lose ${weightToLose().toStringAsFixed(1)} kg to reach normal BMI',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (bmi <= 24.9 && bmi >= 18.5)
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'You have a perfect BMI',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
