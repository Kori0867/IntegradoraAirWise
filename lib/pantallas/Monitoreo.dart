import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'gtemp.dart';
import 'ghume.dart';

class MonitoreoScreen extends StatefulWidget {
  @override
  _MonitoreoScreenState createState() => _MonitoreoScreenState();
}

class _MonitoreoScreenState extends State<MonitoreoScreen> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  List<NotificationItem> _notifications = [];

  double _temperatura = 0.0;
  double _humedad = 0.0;
  bool _carbonoAlto = false;
  Timer? _notificationTimer;

  StreamSubscription<DatabaseEvent>? _tempSubscription;
  StreamSubscription<DatabaseEvent>? _humiSubscription;
  StreamSubscription<DatabaseEvent>? _carbonSubscription;

  @override
  void initState() {
    super.initState();
    _startDataFetching();
    _startNotificationTimer();
  }

  void _startDataFetching() {
    _tempSubscription = _databaseRef.child('test/temperatura').onValue.listen((event) {
      final temp = (event.snapshot.value as num?)?.toDouble() ?? 0.0;
      setState(() {
        _temperatura = temp;
      });
      _checkTemperatureAlerts(temp);
    });

    _humiSubscription = _databaseRef.child('test/humedad').onValue.listen((event) {
      final humi = (event.snapshot.value as num?)?.toDouble() ?? 0.0;
      setState(() {
        _humedad = humi;
      });
      _checkHumidityAlerts(humi);
    });

    _carbonSubscription = _databaseRef.child('test/carbon').onValue.listen((event) {
      final carbon = event.snapshot.value as bool? ?? false;
      setState(() {
        _carbonoAlto = carbon;
      });
      _checkCarbonAlerts(carbon);
    });
  }

  void _startNotificationTimer() {
    _notificationTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      _addNotification();
    });
  }

  void _addNotification() {
    setState(() {
      _notifications.add(NotificationItem(
        title: "Estado Actual",
        body: "Temperatura: $_temperatura °C, Humedad: $_humedad%, CO2: ${_carbonoAlto ? 'Alto' : 'Normal'}",
      ));
    });
  }

  void _showAlert(BuildContext context, String title, String desc) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  void _checkTemperatureAlerts(double temp) {
    if (temp > 40) {
      _showAlert(context, "Alerta de Temperatura", "Temperatura muy alta: $temp °C");
    } else if (temp < 0) {
      _showAlert(context, "Alerta de Temperatura", "Temperatura muy baja: $temp °C");
    }
  }

  void _checkHumidityAlerts(double humi) {
    if (humi > 70) {
      _showAlert(context, "Alerta de Humedad", "Humedad alta: $humi%");
    } else if (humi < 0) {
      _showAlert(context, "Alerta de Humedad", "Humedad baja: $humi%");
    }
  }

  void _checkCarbonAlerts(bool carbon) {
    if (carbon) {
      _showAlert(context, "Alerta de Carbono", "Nivel de carbono alto detectado");
    }
  }

  void _refreshNotifications() {
    _addNotification(); // Actualiza inmediatamente con los datos actuales
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Monitoreo"),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshNotifications, // Botón de refresh
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificacionesScreen(notifications: _notifications),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.maxWidth * 0.8,
                    height: constraints.maxWidth * 0.5,
                    child: GTemp(temperatura: _temperatura),
                  );
                },
              ),
              SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.maxWidth * 0.8,
                    height: constraints.maxWidth * 0.5,
                    child: GHume(humedad: _humedad),
                  );
                },
              ),
              SizedBox(height: 20),
              Text("Temperatura: $_temperatura °C"),
              SizedBox(height: 10),
              Text("Humedad: $_humedad%"),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                color: _temperatura < 0 ? Colors.blue : (_temperatura > 40 ? Colors.red : Colors.green),
                child: Center(
                  child: Text(
                    _temperatura < 0
                        ? "Hace frío"
                        : (_temperatura > 40 ? "Temperatura muy alta" : "Temperatura agradable"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(16),
                color: _humedad < 0 ? Colors.brown : (_humedad > 70 ? Colors.purple : Colors.yellow),
                child: Center(
                  child: Text(
                    _humedad < 0
                        ? "Tiempo seco"
                        : (_humedad > 70 ? "Humedad alta" : "Humedad media"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(16),
                color: _carbonoAlto ? Colors.red : Colors.green,
                child: Center(
                  child: Text(
                    _carbonoAlto ? "Nivel de Co2 alto" : "Nivel de C02 normal",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _notificationTimer?.cancel();
    _tempSubscription?.cancel();
    _humiSubscription?.cancel();
    _carbonSubscription?.cancel();
    super.dispose();
  }
}

class NotificationItem {
  final String title;
  final String body;

  NotificationItem({required this.title, required this.body});
}

class NotificacionesScreen extends StatelessWidget {
  final List<NotificationItem> notifications;

  NotificacionesScreen({required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Últimos Mensajes'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index].title),
            subtitle: Text(notifications[index].body),
          );
        },
      ),
    );
  }
}
