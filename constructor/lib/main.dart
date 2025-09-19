import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bidding Page',
      home: MaximumBid(),
    );
  }
}

class MaximumBid extends StatefulWidget {
  @override
  _MaximumBidState createState() => _MaximumBidState();
}

class _MaximumBidState extends State<MaximumBid> {
  int _current = 0; // Starting bid

  void _increaseBid() {
    setState(() {
      _current += 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bidding Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current Maximum Bid:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              '\$$_current',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _increaseBid,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Sets button color to black
                foregroundColor: Colors.white, // Sets text color to white
              ),
              child: Text('Increase Bid by \$50'),
            ),
          ],
        ),
      ),
    );
  }
}
