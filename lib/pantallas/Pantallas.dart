import 'package:flutter/material.dart';
import 'Home.dart';
import 'Notificacion.dart';
import 'Conectores.dart';
import 'Monitoreo.dart';

class Pantallas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantallas'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Text('Ir a Home'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConectoresScreen()),
              );
            },
            child: Text('Ir a Conectores'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MonitoreoScreen()),
              );
            },
            child: Text('Ir a Monitoreo'),
          ),
        ],
      ),
    );
  }
}
