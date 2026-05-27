import 'package:flutter/material.dart';
import 'app.dart';
import 'data/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notif = FlutterLocalNotificationsServiceImpl();
  await notif.initialize();
  runApp(HabitiousApp(notifications: notif));
}
