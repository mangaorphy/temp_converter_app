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
  final List<String> _history = [];

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
      operation = 'F to C: $inputValue°F → ${convertedValue.toStringAsFixed(2)}°C';
    } else {
      // Celsius to Fahrenheit
      convertedValue = inputValue * 9 / 5 + 32;
      operation = 'C to F: $inputValue°C → ${convertedValue.toStringAsFixed(2)}°F';
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
    // Use SingleChildScrollView to allow scrolling if content overflows
    return Stack(
      children: [
        // Background Image
        SizedBox.expand(
          child: Image.asset(
            'assets/background.jpg',
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
          ),
        ),

        // Foreground Content with White Text
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Conversion:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: RadioListTile<bool>(
                        title: Text(
                          'Fahrenheit to Celsius',
                          // overflow: TextOverflow.ellipsis,
                          // softWrap: false,
                          style: const TextStyle(color: Colors.white),
                        ),
                        value: true,
                        groupValue: _isFtoC,
                        onChanged: (value) {
                          setState(() {
                            _isFtoC = value!;
                          });
                        },
                        activeColor: Colors.white,
                        toggleable: true,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<bool>(
                        title: Text(
                          'Celsius to Fahrenheit',
                          // overflow: TextOverflow.ellipsis,
                          // softWrap: true,
                          style: const TextStyle(color: Colors.white),
                        ),
                        value: false,
                        groupValue: _isFtoC,
                        onChanged: (value) {
                          setState(() {
                            _isFtoC = value!;
                          });
                        },
                        activeColor: Colors.white,
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
                        style: const TextStyle(color: Colors.white), // Input text color
                        decoration: const InputDecoration(
                          labelText: 'Enter Temperature',
                          labelStyle: TextStyle(color: Colors.white70),
                          hintText: 'e.g. 98.6',
                          hintStyle: TextStyle(color: Colors.white60),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Equal Sign
                    const Text(
                      '=',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Output Field
                    Expanded(
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _result ?? '0.00',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Result display
                if (_result != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Result: $_result°C',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green, // Change to a contrasting color
                      ),
                    ),
                  ),

                const SizedBox(height: 24),

                // History section
                const Text(
                  'Conversion History:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),

                // History List Items
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _history.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          _history[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

  }
}