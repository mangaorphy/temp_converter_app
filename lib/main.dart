import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue, // Material 3 - uses blue as primary color
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Converter'),
        ),
        body: SafeArea(child: HomeScreen(),
        )
      ),
    );
  }
}