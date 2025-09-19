import 'dart:io';

void main() {
  // Step 1: Get name and age
  stdout.write('Enter your name: ');
  String? name = stdin.readLineSync();

  stdout.write('Enter your age: ');
  int? age = int.tryParse(stdin.readLineSync() ?? '');

  if (name == null || name.isEmpty || age == null) {
    print('Invalid name or age entered.');
    return;
  }

  if (age < 18) {
    print('Sorry $name, you are not eligible to register.');
    return;
  }

  print('Welcome $name! You are eligible to register.');

  // Step 2: Ask how many numbers to enter
  stdout.write('How many numbers do you want to enter? ');
  int? n = int.tryParse(stdin.readLineSync() ?? '');

  if (n == null || n <= 0) {
    print('Please enter a valid positive number.');
    return;
  }

  // Step 3: Input numbers into a list
  List<int> numbers = [];

  for (int i = 0; i < n; i++) {
    stdout.write('Enter number ${i + 1}: ');
    int? num = int.tryParse(stdin.readLineSync() ?? '');

    if (num == null) {
      print('Invalid input. Please enter a number.');
      i--; // Repeat this iteration
      continue;
    }

    numbers.add(num);
  }

  // Step 4: Perform calculations
  int evenSum = numbers.where((num) => num % 2 == 0).fold(0, (a, b) => a + b);
  int oddSum = numbers.where((num) => num % 2 != 0).fold(0, (a, b) => a + b);
  int largest = numbers.reduce((a, b) => a > b ? a : b);
  int smallest = numbers.reduce((a, b) => a < b ? a : b);

  // Step 5: Print results
  print('----------- Results -----------');
  print('Sum of even numbers  : $evenSum');
  print('Sum of odd numbers   : $oddSum');
  print('Largest number       : $largest');
  print('Smallest number      : $smallest');
  print('-------------------------------');
}
