import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const LifeApp());
}

class LifeApp extends StatelessWidget {
  const LifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int lifeScore = 0;
  int waterCups = 0;
  int pushUps = 0;
  Duration runningTime = Duration.zero;
  double sleepHours = 0;
  Duration studyTime = Duration.zero;
  bool fajr = false, dhuhr = false, asr = false, maghrib = false, isha = false;

  void updateScore(int value) => setState(() => lifeScore += value);

  void resetAll() {
    setState(() {
      lifeScore = 0;
      waterCups = 0;
      pushUps = 0;
      runningTime = Duration.zero;
      sleepHours = 0;
      studyTime = Duration.zero;
      fajr = dhuhr = asr = maghrib = isha = false;
    });
  }

  Widget buildBigButton(String title, IconData icon, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(16),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 38, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttons = [
      buildBigButton('Prayer', Icons.mosque, Colors.teal, () {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => PrayerPage(
            onScoreChange: updateScore,
            fajr: fajr,
            dhuhr: dhuhr,
            asr: asr,
            maghrib: maghrib,
            isha: isha,
            onToggle: (name, value) {
              setState(() {
                switch (name) {
                  case 'Fajr':
                    fajr = value;
                    break;
                  case 'Dhuhr':
                    dhuhr = value;
                    break;
                  case 'Asr':
                    asr = value;
                    break;
                  case 'Maghrib':
                    maghrib = value;
                    break;
                  case 'Isha':
                    isha = value;
                    break;
                }
              });
            },
          ),
        ));
      }),
      buildBigButton('Water', Icons.local_drink, Colors.blue, () {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => WaterPage(
            onScoreChange: updateScore,
            cups: waterCups,
            onCupsChange: (v) => setState(() => waterCups = v),
          ),
        ));
      }),
      buildBigButton('Exercise', Icons.fitness_center, Colors.orange, () {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => ExercisePage(
            onScoreChange: updateScore,
            pushUps: pushUps,
            runningTime: runningTime,
            onPushUpChange: (v) => setState(() => pushUps = v),
            onRunningChange: (t) => setState(() => runningTime = t),
          ),
        ));
      }),
      buildBigButton('Study', Icons.menu_book, Colors.purple, () {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => StudyPage(
            onScoreChange: updateScore,
            studyTime: studyTime,
            onStudyChange: (t) => setState(() => studyTime = t),
          ),
        ));
      }),
      buildBigButton('Sleep', Icons.bed, Colors.indigo, () {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => SleepPage(
            onScoreChange: updateScore,
            sleepHours: sleepHours,
            onSleepChange: (v) => setState(() => sleepHours = v),
          ),
        ));
      }),
      buildBigButton('Reset', Icons.refresh, Colors.redAccent, resetAll),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Life Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              "Life Score: $lifeScore",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: (lifeScore % 100) / 100,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              color: Colors.teal,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1,
                children: buttons,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Prayer Page ----------------
class PrayerPage extends StatefulWidget {
  final void Function(int) onScoreChange;
  final bool fajr, dhuhr, asr, maghrib, isha;
  final void Function(String name, bool value) onToggle;
  const PrayerPage({
    super.key,
    required this.onScoreChange,
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.onToggle,
  });

  @override
  State<PrayerPage> createState() => _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage> {
  late bool fajr = widget.fajr;
  late bool dhuhr = widget.dhuhr;
  late bool asr = widget.asr;
  late bool maghrib = widget.maghrib;
  late bool isha = widget.isha;

  void togglePrayer(bool value, String name) {
    setState(() {
      switch (name) {
        case 'Fajr':
          fajr = value;
          break;
        case 'Dhuhr':
          dhuhr = value;
          break;
        case 'Asr':
          asr = value;
          break;
        case 'Maghrib':
          maghrib = value;
          break;
        case 'Isha':
          isha = value;
          break;
      }
      widget.onScoreChange(value ? 10 : -10);
      widget.onToggle(name, value);
    });
  }

  Widget prayerCheck(String name, bool val) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: CheckboxListTile(
        title: Text(name, style: const TextStyle(fontSize: 18)),
        value: val,
        activeColor: Colors.teal,
        onChanged: (v) => togglePrayer(v ?? false, name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prayer')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Tap to mark/unmark prayer (±10 points)', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),
          prayerCheck('Fajr', fajr),
          prayerCheck('Dhuhr', dhuhr),
          prayerCheck('Asr', asr),
          prayerCheck('Maghrib', maghrib),
          prayerCheck('Isha', isha),
        ],
      ),
    );
  }
}

// ---------------- Water Page ----------------
class WaterPage extends StatefulWidget {
  final void Function(int) onScoreChange;
  final int cups;
  final void Function(int) onCupsChange;
  const WaterPage({super.key, required this.onScoreChange, required this.cups, required this.onCupsChange});

  @override
  State<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  late int localCups;

  @override
  void initState() {
    super.initState();
    localCups = widget.cups;
  }

  void addCup() {
    setState(() => localCups++);
    widget.onCupsChange(localCups);
    widget.onScoreChange(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Water Tracker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Water Cups: $localCups', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            OutlinedButton(
              onPressed: addCup,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.teal, width: 2),
                padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Add Water Cup', style: TextStyle(fontSize: 18, color: Colors.teal)),
            )
          ],
        ),
      ),
    );
  }
}

// ---------------- Exercise Page ----------------
class ExercisePage extends StatefulWidget {
  final void Function(int) onScoreChange;
  final int pushUps;
  final Duration runningTime;
  final void Function(int) onPushUpChange;
  final void Function(Duration) onRunningChange;
  const ExercisePage({
    super.key,
    required this.onScoreChange,
    required this.pushUps,
    required this.runningTime,
    required this.onPushUpChange,
    required this.onRunningChange,
  });

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final TextEditingController pushUpController = TextEditingController();
  final TextEditingController runController = TextEditingController();
  late int localPushUps;
  late Duration localRunning;

  @override
  void initState() {
    super.initState();
    localPushUps = widget.pushUps;
    localRunning = widget.runningTime;
  }

  @override
  void dispose() {
    pushUpController.dispose();
    runController.dispose();
    super.dispose();
  }

  void addPushUps() {
    final count = int.tryParse(pushUpController.text) ?? 0;
    if (count > 0) {
      setState(() => localPushUps += count);
      widget.onPushUpChange(localPushUps);
      widget.onScoreChange(count);
      pushUpController.clear();
    }
  }

  void addRunningTime() {
    final mins = int.tryParse(runController.text) ?? 0;
    if (mins > 0) {
      setState(() => localRunning = localRunning + Duration(minutes: mins));
      widget.onRunningChange(localRunning);
      widget.onScoreChange(mins * 5);
      runController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Push Ups: $localPushUps', style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: pushUpController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Push-up count',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: addPushUps,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.teal, width: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Add", style: TextStyle(color: Colors.teal)),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Text('Running: ${localRunning.inMinutes} minutes', style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: runController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Minutes Run',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: addRunningTime,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.teal, width: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Add", style: TextStyle(color: Colors.teal)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ---------------- Study Page ----------------
class StudyPage extends StatefulWidget {
  final void Function(int) onScoreChange;
  final Duration studyTime;
  final void Function(Duration) onStudyChange;
  const StudyPage({super.key, required this.onScoreChange, required this.studyTime, required this.onStudyChange});

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  final TextEditingController studyController = TextEditingController();
  late Duration localStudy;

  @override
  void initState() {
    super.initState();
    localStudy = widget.studyTime;
  }

  @override
  void dispose() {
    studyController.dispose();
    super.dispose();
  }

  void addStudyTime() {
    final mins = int.tryParse(studyController.text) ?? 0;
    if (mins > 0) {
      setState(() => localStudy = localStudy + Duration(minutes: mins));
      widget.onStudyChange(localStudy);
      widget.onScoreChange((mins ~/ 30) * 5);
      studyController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final hours = localStudy.inHours;
    final mins = localStudy.inMinutes % 60;
    return Scaffold(
      appBar: AppBar(title: const Text('Study Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Study Time: ${hours}h ${mins}m', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: studyController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Minutes studied',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: addStudyTime,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.teal, width: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Add", style: TextStyle(color: Colors.teal)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ---------------- Sleep Page ----------------
class SleepPage extends StatefulWidget {
  final void Function(int) onScoreChange;
  final double sleepHours;
  final void Function(double) onSleepChange;
  const SleepPage({super.key, required this.onScoreChange, required this.sleepHours, required this.onSleepChange});

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  final TextEditingController controller = TextEditingController();
  late double localHours;

  @override
  void initState() {
    super.initState();
    localHours = widget.sleepHours;
  }

  void addSleep() {
    final hours = double.tryParse(controller.text) ?? 0;
    if (hours > 0) {
      setState(() => localHours += hours);
      widget.onSleepChange(localHours);
      widget.onScoreChange(hours >= 8 ? 10 : 5);
      controller.clear();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sleep Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Last Sleep: ${localHours.toStringAsFixed(1)} h', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Hours slept',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: addSleep,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.teal, width: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Add", style: TextStyle(color: Colors.teal)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
