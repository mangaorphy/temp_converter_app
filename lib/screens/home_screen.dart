import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _tempController = TextEditingController();

  bool _isFtoC = true;
  String? _result;
  List<String> _history = [];

  void _convertTemperature() {
    final input = _tempController.text;

    if (input.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a temperature value')),
      );
      return;
    }

    double inputValue = double.tryParse(input)!;

    double convertedValue;
    String operation;

    if (_isFtoC) {
      // Fahrenheit to Celsius
      convertedValue = (inputValue - 32) * 5 / 9;
      operation = '$inputValue°F → ${convertedValue.toStringAsFixed(2)}°C';
    } else {
      // Celsius to Fahrenheit
      convertedValue = inputValue * 9 / 5 + 32;
      operation = '$inputValue°C → ${convertedValue.toStringAsFixed(2)}°F';
    }

    setState(() {
      _result = convertedValue.toStringAsFixed(2);
      _history.insert(0, operation); // Add to top of list
    });
  }

  @override
  void dispose() {
    _tempController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title for conversion selection
          const Text(
            'Conversion:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Two radio buttons in a row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  title: const Text('Fahrenheit to Celsius'),
                  value: true,
                  groupValue: _isFtoC,
                  onChanged: (value) {
                    setState(() {
                      _isFtoC = value!;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<bool>(
                  title: const Text('Celsius to Fahrenheit'),
                  value: false,
                  groupValue: _isFtoC,
                  onChanged: (value) {
                    setState(() {
                      _isFtoC = value!;
                    });
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Input field
          Row(
            children: [
              // Input Field
              Expanded(
                child: TextField(
                  controller: _tempController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter Temperature',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Equal Sign
              const Text(
                '=',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(width: 8),

              // Output Field
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _result ?? '0.00',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

            const SizedBox(height: 24),

            // Convert button
            Center(
              child: ElevatedButton(
                onPressed: _convertTemperature,
                child: const Text('Convert'),
              ),
            ),

            const SizedBox(height: 24),

            // Result display
            if (_result != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Result: $_result°C',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

            const SizedBox(height: 24),

            // History section
            const Text(
              'Conversion History:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }