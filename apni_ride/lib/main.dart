import 'package:flutter/material.dart';
import 'dart:ui';
void main() {
  runApp(const TaxiApp());
}

class TaxiApp extends StatefulWidget {
  const TaxiApp({super.key});

  @override
  State<TaxiApp> createState() => _TaxiAppState();
}

class _TaxiAppState extends State<TaxiApp> {
  bool isLoggedIn = false;

  void login() {
    setState(() => isLoggedIn = true);
  }

  void logout() {
    setState(() => isLoggedIn = false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apni Ride',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: SplashScreen(onLogin: login, isLoggedIn: isLoggedIn),
    );
  }
}

// ================== 1. SPLASH SCREEN ==================
class SplashScreen extends StatefulWidget {
  final VoidCallback onLogin;
  final bool isLoggedIn;
  const SplashScreen({super.key, required this.onLogin, required this.isLoggedIn});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => opacityLevel = 1.0);
    });
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => widget.isLoggedIn
              ? BookingScreen(
            driverName: "Ali Khan",
            driverPhone: "03001234567",
            carName: "Suzuki Alto",
            isLoggedIn: widget.isLoggedIn,
            onLogin: widget.onLogin,
          )
              : LoginScreen(onLogin: widget.onLogin),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 3),
          opacity: opacityLevel,
          child: Text(
            "Welcome to Apni Ride",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade300,
              shadows: [
                Shadow(
                  color: Colors.amber.shade700,
                  blurRadius: 12,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================== GRADIENT BACKGROUND ==================
class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.amber.shade300,
            Colors.amber.shade100,
          ],
        ),
      ),
      child: child,
    );
  }
}

// ================== 2. LOGIN SCREEN ==================
class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin;
  const LoginScreen({super.key, required this.onLogin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  void loginUser() {
    final phone = phoneController.text.trim();

    if (nameController.text.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter digits only for phone number")),
      );
      return;
    }

    widget.onLogin();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BookingScreen(
          driverName: "Ali Khan",
          driverPhone: "03001234567",
          carName: "Suzuki Alto",
          isLoggedIn: true,
          onLogin: widget.onLogin,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login in Apni Ride"),
        backgroundColor: Colors.amber.shade700,
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/car.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Blur layer
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(color: Colors.black.withOpacity(0.2)),
            ),
          ),

          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.amber.withOpacity(0.3),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),

          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade700,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),


    );
  }
}

// ================== 3. BOOKING SCREEN ==================
class BookingScreen extends StatefulWidget {
  final String driverName;
  final String driverPhone;
  final String carName;
  final bool isLoggedIn;
  final VoidCallback onLogin;

  const BookingScreen({
    super.key,
    required this.driverName,
    required this.driverPhone,
    required this.carName,
    required this.isLoggedIn,
    required this.onLogin,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final pickupController = TextEditingController();
  final destinationController = TextEditingController();
  final distanceController = TextEditingController();
  double fare = 0.0;
  double estimatedTime = 0.0;

  void calculateFare() {
    String distanceText = distanceController.text.trim();

    if (!RegExp(r'^[0-9.]+$').hasMatch(distanceText)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter digits only for distance")),
      );
      return;
    }

    double distance = double.tryParse(distanceText) ?? 0.0;
    setState(() {
      if (distance <= 0) {
        fare = 0;
        estimatedTime = 0;
      } else {
        fare = 100 + (20 * distance);
        estimatedTime = (distance / 40) * 60; // 40 km/h
      }
    });
  }

  void handleBooking() {
    if (fare > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DriverAssignScreen(
            pickup: pickupController.text,
            destination: destinationController.text,
            distance: double.tryParse(distanceController.text) ?? 0.0,
            fare: fare,
            estimatedTime: estimatedTime,
            driverName: widget.driverName,
            driverPhone: widget.driverPhone,
            carName: widget.carName,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid details and calculate fare first")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Your Ride"),
        backgroundColor: Colors.amber.shade700,
      ),
      body: GradientBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: pickupController,
                 // textAlign: TextAlign.center,
                  decoration: const InputDecoration(labelText: "Pickup Location"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: destinationController,
              //    textAlign: TextAlign.center,
                  decoration: const InputDecoration(labelText: "Destination"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: distanceController,
              //    textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Distance (km)"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: calculateFare, child: const Text("Calculate Fare")),
                const SizedBox(height: 15),
                Text(
                  "Estimated Fare: Rs. ${fare.toStringAsFixed(0)}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Estimated Time: ${estimatedTime.toStringAsFixed(1)} min",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: handleBooking,
                  child: const Text("Book Now"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================== 4. DRIVER ASSIGN SCREEN ==================
class DriverAssignScreen extends StatelessWidget {
  final String pickup;
  final String destination;
  final double distance;
  final double fare;
  final double estimatedTime;
  final String driverName;
  final String driverPhone;
  final String carName;

  const DriverAssignScreen({
    super.key,
    required this.pickup,
    required this.destination,
    required this.distance,
    required this.fare,
    required this.estimatedTime,
    required this.driverName,
    required this.driverPhone,
    required this.carName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Assigned"),
        backgroundColor: Colors.amber.shade700,
      ),
      body: GradientBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Driver Assigned 🚘",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text("Driver: $driverName"),
                Text("Phone: $driverPhone"),
                Text("Car: $carName"),
                Text("Estimated Arrival: 15 minutes"),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookingConfirmationScreen(
                          pickup: pickup,
                          destination: destination,
                          distance: distance,
                          fare: fare,
                          estimatedTime: estimatedTime,
                          driverName: driverName,
                          driverPhone: driverPhone,
                          carName: carName,
                        ),
                      ),
                    );
                  },
                  child: const Text("Confirm Ride"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================== 5. BOOKING CONFIRMATION SCREEN ==================
class BookingConfirmationScreen extends StatelessWidget {
  final String pickup;
  final String destination;
  final double distance;
  final double fare;
  final double estimatedTime;
  final String driverName;
  final String driverPhone;
  final String carName;

  const BookingConfirmationScreen({
    super.key,
    required this.pickup,
    required this.destination,
    required this.distance,
    required this.fare,
    required this.estimatedTime,
    required this.driverName,
    required this.driverPhone,
    required this.carName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Confirmation"),
        backgroundColor: Colors.amber.shade700,
      ),
      body: GradientBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Ride Confirmed ✅",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text("Pickup: $pickup"),
                Text("Destination: $destination"),
                Text("Distance: ${distance.toStringAsFixed(1)} km"),
                Text("Fare: Rs. ${fare.toStringAsFixed(0)}"),
                Text("Estimated Time: ${estimatedTime.toStringAsFixed(1)} min"),
                const SizedBox(height: 20),
                Text("Driver: $driverName"),
                Text("Phone: $driverPhone"),
                Text("Car: $carName"),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookingScreen(
                          driverName: driverName,
                          driverPhone: driverPhone,
                          carName: carName,
                          isLoggedIn: true,
                          onLogin: () {},
                        ),
                      ),
                          (route) => false,
                    );
                  },
                  child: const Text("Finish"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
