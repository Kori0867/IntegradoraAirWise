import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificacionScreen {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  List<NotificationItem> _notifications = [];

  NotificacionScreen() {
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    try {
      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      );
    } catch (e) {
      print("Error inicializando notificaciones: $e");
    }
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'mi_canal_de_notificacion_name',
      'mi_canal_de_notificacion_description',
      channelDescription: 'Notificaciones importantes sobre mi aplicación',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    try {
      await _flutterLocalNotificationsPlugin.show(
        _notifications.length,
        title,
        body,
        platformChannelSpecifics,
        payload: 'item x',
      );

      // Agrega la notificación a la lista de notificaciones
      _notifications.add(NotificationItem(title: title, body: body));
    } catch (e) {
      print("Error mostrando notificación: $e");
    }
  }

  void _onDidReceiveNotificationResponse(NotificationResponse notificationResponse) {
    // Manejo de la acción al seleccionar una notificación
    // Puedes utilizar notificationResponse.payload si lo necesitas
  }

  List<NotificationItem> getNotifications() {
    return _notifications;
  }
}

class NotificationItem {
  String title;
  String body;

  NotificationItem({required this.title, required this.body});
}
