import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Widget Tree'),
        ),
        body: const SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: ContainerWithBoxDecorationWidget(),
          ),
        ),
      ),
    );
  }
}

class ContainerWithBoxDecorationWidget extends StatelessWidget {
  const ContainerWithBoxDecorationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // --- Gradient Container with RichText ---
        Container(
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(100.0),
              bottomRight: Radius.circular(10.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.lightGreen.shade500,
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center, // ✅ avoids alignment issues
              text: const TextSpan(
                text: 'Flutter World ',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.deepPurple,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.deepPurpleAccent,
                  decorationStyle: TextDecorationStyle.dotted,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'for '),
                  TextSpan(
                    text: 'Mobile',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // --- Simple Column ---
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Text('Column 1'),
            Divider(),
            Text('Column 2'),
            Divider(),
            Text('Column 3'),
          ],
        ),

        const SizedBox(height: 20),

        // --- Simple Row ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            Text('Row 1'),
            Text('Row 2'),
            Text('Row 3'),
          ],
        ),

        const SizedBox(height: 20),

        // --- Column with Row Nesting ---
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Columns and Row Nesting 1'),
            const Text('Columns and Row Nesting 2'),
            const Text('Columns and Row Nesting 3'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                Text('Row Nesting 1'),
                Text('Row Nesting 2'),
                Text('Row Nesting 3'),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        // --- Duplicate Column with Row Nesting ---
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Columns and Row Nesting 1'),
            const Text('Columns and Row Nesting 2'),
            const Text('Columns and Row Nesting 3'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                Text('Row Nesting 1'),
                Text('Row Nesting 2'),
                Text('Row Nesting 3'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
