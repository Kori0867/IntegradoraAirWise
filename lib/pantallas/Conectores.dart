import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConectoresScreen(),
    );
  }
}

class ConectoresScreen extends StatefulWidget {
  @override
  _ConectoresScreenState createState() => _ConectoresScreenState();
}

class _ConectoresScreenState extends State<ConectoresScreen> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref().child('test/');

  bool _r1Value = false;
  bool _r2Value = false;
  bool _r3Value = false;
  bool _r4Value = false;

  void _updateValue(String key, bool value) {
    _databaseRef.child(key).set(value);
    setState(() {
      switch (key) {
        case 'R1':
          _r1Value = value;
          break;
        case 'R2':
          _r2Value = value;
          break;
        case 'R3':
          _r3Value = value;
          break;
        case 'R4':
          _r4Value = value;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conectores'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CustomListTile(
              title: "Ventilador",
              value: _r1Value,
              icon: Icons.air,
              onChanged: (value) => _updateValue('R1', value),
            ),
            _CustomListTile(
              title: "Calentón",
              value: _r2Value,
              icon: Icons.local_fire_department,
              onChanged: (value) => _updateValue('R2', value),
            ),
            _CustomListTile(
              title: "Cargador",
              value: _r3Value,
              icon: Icons.charging_station,
              onChanged: (value) => _updateValue('R3', value),
            ),
            _CustomListTile(
              title: "Lampara",
              value: _r4Value,
              icon: Icons.light,
              onChanged: (value) => _updateValue('R4', value),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final bool value;
  final IconData icon;
  final ValueChanged<bool> onChanged;

  _CustomListTile({required this.title, required this.value, required this.icon, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            size: 40,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          trailing: CupertinoSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
