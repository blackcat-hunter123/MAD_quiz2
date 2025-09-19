import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: RegistrationForm()));
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final countController = TextEditingController();

  String? result;
  bool isEligible = false;
  int numberCount = 0;
  List<TextEditingController> numberControllers = [];

  void register() {
    String name = nameController.text;
    int? age = int.tryParse(ageController.text);

    if (age == null) {
      setState(() {
        result = 'Invalid age.';
        isEligible = false;
      });
      return;
    }

    if (age < 18) {
      setState(() {
        result = 'Sorry $name, you are not eligible to register.';
        isEligible = false;
      });
    } else {
      setState(() {
        result =
        'Welcome $name! You are eligible.\nNow, enter how many numbers you want to input.';
        isEligible = true;
      });
    }
  }

  void generateNumberInputs() {
    int? n = int.tryParse(countController.text);
    if (n == null || n <= 0) {
      setState(() {
        result = 'Please enter a valid number count.';
      });
      return;
    }

    setState(() {
      numberCount = n;
      numberControllers = List.generate(n, (index) => TextEditingController());
      result = null;
    });
  }

  void calculateResults() {
    List<int> numbers = [];

    for (var controller in numberControllers) {
      int? num = int.tryParse(controller.text);
      if (num == null) {
        setState(() {
          result = 'Please enter only valid numbers.';
        });
        return;
      }
      numbers.add(num);
    }

    int evenSum = numbers.where((n) => n % 2 == 0).fold(0, (a, b) => a + b);
    int oddSum = numbers.where((n) => n % 2 != 0).fold(0, (a, b) => a + b);
    int max = numbers.reduce((a, b) => a > b ? a : b);
    int min = numbers.reduce((a, b) => a < b ? a : b);

    setState(() {
      result = '''
 Results:
 Sum of even numbers: $evenSum
 Sum of odd numbers: $oddSum
 Largest number: $max
 Smallest number: $min
''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: Text('Riphah International University - Registration')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: register,
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Step 1: Enter how many numbers
            if (isEligible) ...[
              TextField(
                controller: countController,
                decoration: InputDecoration(
                    labelText: 'How many numbers do you want to enter?'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              Center( // Center button here
                child: ElevatedButton(
                  onPressed: generateNumberInputs,
                  child: Text('Generate Number Inputs'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],

            // Step 2: Enter the numbers
            if (numberControllers.isNotEmpty) ...[
              SizedBox(height: 20),
              Text('Enter $numberCount numbers:'),
              SizedBox(height: 10),
              for (int i = 0; i < numberControllers.length; i++)
                TextField(
                  controller: numberControllers[i],
                  decoration: InputDecoration(labelText: 'Number ${i + 1}'),
                  keyboardType: TextInputType.number,
                ),
              SizedBox(height: 20),
              Center( // Center button here
                child: ElevatedButton(
                  onPressed: calculateResults,
                  child: Text('Calculate Results'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],

            // Step 3: Show Results
            if (result != null) ...[
              SizedBox(height: 30),
              Text(
                result!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
