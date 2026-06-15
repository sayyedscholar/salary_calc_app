import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Add the constructor with the named 'key' parameter
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salary Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SalaryCalculator(),
    );
  }
}

class SalaryCalculator extends StatefulWidget {
  const SalaryCalculator({super.key});

  @override
  State<SalaryCalculator> createState() => _SalaryCalculatorState();
}

class _SalaryCalculatorState extends State<SalaryCalculator> {
  final _controller = TextEditingController();
  String result = '';
  String selectedUnit = 'Per Month';

  void calculateSalary() {
    double salary = double.tryParse(_controller.text) ?? 0;

    // Convert input salary based on selected unit
    double perSecond = 0;
    double perMinute = 0;
    double perHour = 0;
    double perDay = 0;
    double perWeek = 0;
    double perMonth = 0;
    double perYear = 0;

    switch (selectedUnit) {
      case 'Per Second':
        perSecond = salary;
        perMinute = perSecond * 60;
        perHour = perMinute * 60;
        perDay = perHour * 24;
        perWeek = perDay * 7;
        perMonth = perWeek * 4.33;
        perYear = perMonth * 12;
        break;

      case 'Per Minute':
        perMinute = salary;
        perSecond = perMinute / 60;
        perHour = perMinute * 60;
        perDay = perHour * 24;
        perWeek = perDay * 7;
        perMonth = perWeek * 4.33;
        perYear = perMonth * 12;
        break;

      case 'Per Hour':
        perHour = salary;
        perMinute = perHour / 60;
        perSecond = perMinute / 60;
        perDay = perHour * 24;
        perWeek = perDay * 7;
        perMonth = perWeek * 4.33;
        perYear = perMonth * 12;
        break;

      case 'Per Day':
        perDay = salary;
        perHour = perDay / 24;
        perMinute = perHour / 60;
        perSecond = perMinute / 60;
        perWeek = perDay * 7;
        perMonth = perWeek * 4.33;
        perYear = perMonth * 12;
        break;

      case 'Per Week':
        perWeek = salary;
        perDay = perWeek / 7;
        perHour = perDay / 24;
        perMinute = perHour / 60;
        perSecond = perMinute / 60;
        perMonth = perWeek * 4.33;
        perYear = perMonth * 12;
        break;

      case 'Per Month':
        perMonth = salary;
        perWeek = perMonth / 4.33;
        perDay = perWeek / 7;
        perHour = perDay / 24;
        perMinute = perHour / 60;
        perSecond = perMinute / 60;
        perYear = perMonth * 12;
        break;

      case 'Per Year':
        perYear = salary;
        perMonth = perYear / 12;
        perWeek = perMonth / 4.33;
        perDay = perWeek / 7;
        perHour = perDay / 24;
        perMinute = perHour / 60;
        perSecond = perMinute / 60;
        break;
    }

    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    );

    setState(() {
      result = '''
        Per Second: ${formatter.format(perSecond)}
        Per Minute: ${formatter.format(perMinute)}
        Per Hour: ${formatter.format(perHour)}
        Per Day: ${formatter.format(perDay)}
        Per Week: ${formatter.format(perWeek)}
        Per Month: ${formatter.format(perMonth)}
        Per Year: ${formatter.format(perYear)}
      ''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Salary Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown to select salary type
            DropdownButton<String>(
              value: selectedUnit,
              onChanged: (String? newValue) {
                setState(() {
                  selectedUnit = newValue!;
                });
              },
              items:
                  <String>[
                    'Per Second',
                    'Per Minute',
                    'Per Hour',
                    'Per Day',
                    'Per Week',
                    'Per Month',
                    'Per Year',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
            SizedBox(height: 16),
            // TextField to input salary
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Salary in $selectedUnit',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateSalary,
              child: Text('Calculate'),
            ),
            SizedBox(height: 16),
            // Display the results
            Text(result, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
