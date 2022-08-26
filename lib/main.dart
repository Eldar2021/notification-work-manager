import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notification_work_manager/fetch_data.dart';
import 'package:workmanager/workmanager.dart';

import 'app.dart';
import 'notification_service.dart';

Future<void> main() async {
  log('message');
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await Workmanager().registerPeriodicTask(
    "task-identifier",
    "simpleTask",
    initialDelay: const Duration(seconds: 15),
    frequency: const Duration(minutes: 15),
  );
  runApp(const MyApp());
}

Future<void> callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    final res = await fetchData();

    res.fold(
      (l) async {
        await NotificationService().showNotification(0, 'Exception1', l.toString());
      },
      (r) async {
        await NotificationService().showNotification(1, r.msg1.title, r.msg1.content);
        await NotificationService().showNotification(2, r.msg2.title, r.msg2.content);
      },
    );

    return Future.value(true);
  });
}
