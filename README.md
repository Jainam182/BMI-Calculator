BMI Calculator App - README

Overview

This is a Flutter-based BMI Calculator app that allows users to input their height and weight to calculate their Body Mass Index (BMI). It features a dynamic UI that updates BMI categories, provides weight loss/gain suggestions, and maintains responsiveness.

Dependencies

Ensure you have the following dependencies installed:

dependencies:
  flutter:
    sdk: flutter
  syncfusion_flutter_gauges: ^21.1.39

Install dependencies using:

flutter pub get

Features Implemented

Dynamic Font Color for BMI Categories

Underweight: Blue

Normal Weight: Green

Overweight: Orange

Obesity: Red

BMI Display Updates Correctly

Displays "Your BMI: 0.0" when height/weight changes.

Displays calculated BMI only after clicking the "Calculate BMI" button.

Weight Loss Message (Red Background)

Appears only when BMI is in the overweight or obesity range.

Displays how much weight needs to be lost to reach a normal BMI.

Normal Weight Message (Green Background)

Displays "You have a perfect BMI" when BMI is in the normal range.

Underweight Message (Blue Background)

Displays "You need to gain X kg to reach normal BMI" when BMI is under 18.5.

UI Responsiveness

All messages reset when the user changes height or weight.

The category name remains visible but updates dynamically.

How to Run the App

Clone the repository or copy the project files.

Navigate to the project folder.

Run:

flutter pub get
flutter run

Notes

The app is optimized for real-time updates and smooth UI interaction.

Ensure you use Flutter 3.x for compatibility.

Run on an emulator or a physical device with Flutter installed.

This README covers all changes made and ensures proper setup for running the BMI Calculator app successfully. 🚀

