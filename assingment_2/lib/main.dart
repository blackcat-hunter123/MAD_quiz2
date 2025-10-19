import 'package:flutter/material.dart';

void main() {
  runApp(const TravelGuideApp());
}

class TravelGuideApp extends StatelessWidget {
  const TravelGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ListScreen(),
    const AboutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Travel Guide')),
      body: SafeArea(child: _screens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
      ),
    );
  }
}

// ===================== HOME SCREEN =====================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController destinationController = TextEditingController();
  List<String> filteredDestinations = [];

  final List<String> destinations = [
    'Paris',
    'Rome',
    'Tokyo',
    'London',
    'New York',
    'Sydney',
    'Egypt',
    'Brazil',
    'Dubai',
    'Turkey',
  ];

  void _onSearchChanged(String value) {
    setState(() {
      filteredDestinations = destinations
          .where((item) => item.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _searchButtonPressed() {
    final query = destinationController.text.trim().toLowerCase();
    final match = destinations.firstWhere(
          (item) => item.toLowerCase() == query,
      orElse: () => '',
    );

    if (match.isNotEmpty) {
      _showDestinationName(match);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Destination not found')),
      );
    }
  }

  void _showDestinationName(String name) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Destination'),
          content: Text(name, style: const TextStyle(fontSize: 18)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset('assets/images/travel.jpg'),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.teal.withOpacity(0.1),
            child: const Text(
              'Welcome to the Travel Guide App! Plan your next adventure easily.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 20, color: Colors.black),
              children: [
                TextSpan(text: 'Explore the '),
                TextSpan(
                    text: 'World ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.teal)),
                TextSpan(text: 'with Us'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: destinationController,
              onChanged: _onSearchChanged,
              decoration: const InputDecoration(
                labelText: 'Enter Destination',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          if (filteredDestinations.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.teal),
                borderRadius: BorderRadius.circular(4),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredDestinations.length,
                itemBuilder: (context, index) {
                  final name = filteredDestinations[index];
                  return ListTile(
                    title: Text(name),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      destinationController.text = name;
                      filteredDestinations.clear();
                      _showDestinationName(name);
                    },
                  );
                },
              ),
            ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: _searchButtonPressed,
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}

// ===================== LIST SCREEN =====================
class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> destinations = [
      {
        'name': 'Paris',
        'info': 'Paris is the capital of France.\n'
            'Known as the City of Light.\n'
            'Famous for the Eiffel Tower.\n'
            'A hub of art, culture, and fashion.\n'
            'The Louvre Museum is here.\n'
            'The Seine River flows through.\n'
            'Great food and cafes.\n'
            'Historic buildings everywhere.\n'
            'Romantic atmosphere.\n'
            'A must visit destination.'
      },
      {
        'name': 'Rome',
        'info': 'Rome is the capital of Italy.\n'
            'Known for the Colosseum.\n'
            'Center of ancient Roman Empire.\n'
            'Vatican City is nearby.\n'
            'Rich culture and architecture.\n'
            'Home of Roman Forum.\n'
            'Beautiful churches and fountains.\n'
            'Delicious Italian cuisine.\n'
            'Warm climate most of the year.\n'
            'A perfect historic travel spot.'
      },
      {
        'name': 'Tokyo',
        'info': 'Tokyo is the capital of Japan.\n'
            'A city of modern technology.\n'
            'Also rich in tradition.\n'
            'Known for cherry blossoms.\n'
            'Very clean and organized.\n'
            'Great public transport.\n'
            'Famous for Shibuya Crossing.\n'
            'Temples and shrines everywhere.\n'
            'Delicious sushi and ramen.\n'
            'A mix of old and new.'
      },
      {
        'name': 'London',
        'info': 'London is the capital of UK.\n'
            'Famous for Big Ben and the Thames.\n'
            'A multicultural city.\n'
            'Home to the Royal Family.\n'
            'Buckingham Palace is here.\n'
            'Red buses and black cabs.\n'
            'Rich in museums and parks.\n'
            'Rainy but charming.\n'
            'Great shopping and food.\n'
            'A world-class destination.'
      },
      {
        'name': 'New York',
        'info': 'New York is in the USA.\n'
            'Famous for Times Square.\n'
            'Statue of Liberty is here.\n'
            'Very fast city life.\n'
            'Known as the Big Apple.\n'
            'Home of Broadway shows.\n'
            'Diverse food culture.\n'
            'Central Park is huge.\n'
            'Iconic skyline.\n'
            'A city that never sleeps.'
      },
    ];

    void showInfoDialog(String name, String info) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(name),
            content: SingleChildScrollView(child: Text(info)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }

    return ListView.builder(
      itemCount: destinations.length,
      itemBuilder: (context, index) {
        final item = destinations[index];
        return ListTile(
          leading: const Icon(Icons.location_on, color: Colors.teal),
          title: Text(item['name']!),
          onTap: () {
            showInfoDialog(item['name']!, item['info']!);
          },
        );
      },
    );
  }
}

// ===================== ABOUT SCREEN =====================
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final attractions = [
      {'img': 'assets/images/eiffel.jpg', 'name': 'Eiffel Tower'},
      {'img': 'assets/images/colosseum.jpg', 'name': 'Colosseum'},
      {'img': 'assets/images/tajmahal.jpg', 'name': 'Taj Mahal'},
      {'img': 'assets/images/pyramids.jpg', 'name': 'Pyramids'},
      {'img': 'assets/images/christ.jpg', 'name': 'Christ the Redeemer'},
      {'img': 'assets/images/burjkhalifa.jpg', 'name': 'Burj Khalifa'},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.9,
      ),
      itemCount: attractions.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Expanded(
              child: Image.asset(
                attractions[index]['img']!,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              attractions[index]['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}

