import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Dashboard()));

class Dashboard extends StatefulWidget {
  @override
  State createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List devices = [
    {'name': 'Light', 'icon': Icons.lightbulb, 'on': false},
    {'name': 'Fan', 'icon': Icons.air, 'on': false},
  ];

  @override
  Widget build(context) => Scaffold(
    appBar: AppBar(leading: Icon(Icons.menu), title: Text('Smart Home Dashboard'), actions: [Icon(Icons.person)]),
    body: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: devices.length,
      itemBuilder: (_, i) => InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Details(devices[i], () => setState(() {})))),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(devices[i]['icon'], size: 50),
              Text(devices[i]['name']),
              Switch(value: devices[i]['on'], onChanged: (v) => setState(() => devices[i]['on'] = v)),
              Text(devices[i]['on'] ? 'ON' : 'OFF'),
            ],
          ),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        var r = await showDialog(context: context, builder: (_) => AddDevice());
        if (r != null) setState(() => devices.add(r));
      },
    ),
  );
}

class Details extends StatefulWidget {
  final Map device;
  final Function onToggle;
  Details(this.device, this.onToggle);
  @override
  State createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  double level = 50;
  @override
  Widget build(context) => Scaffold(
    appBar: AppBar(title: Text(widget.device['name'])),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.device['icon'], size: 100),
          Text('Status: ${widget.device['on'] ? 'ON' : 'OFF'}'),
          Slider(value: level, max: 100, onChanged: (v) => setState(() => level = v)),
          ElevatedButton(child: Text('Toggle'), onPressed: () {
            widget.device['on'] = !widget.device['on'];
            widget.onToggle();
            Navigator.pop(context);
          }),
        ],
      ),
    ),
  );
}

class AddDevice extends StatefulWidget {
  @override
  State createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  var name = TextEditingController(), type = 'Light';
  @override
  Widget build(context) => AlertDialog(
    title: Text('Add Device'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(controller: name, decoration: InputDecoration(labelText: 'Name')),
        DropdownButton(value: type, items: ['Light', 'Fan', 'AC'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(), onChanged: (v) => setState(() => type = v!)),
      ],
    ),
    actions: [
      TextButton(child: Text('Add'), onPressed: () => Navigator.pop(context, {'name': name.text, 'icon': type == 'Light' ? Icons.lightbulb : type == 'Fan' ? Icons.air : Icons.ac_unit, 'on': false})),
    ],
  );
}