import 'dart:developer';

import 'package:flutter/material.dart';
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
    for (var i = 0; i < 10; i++) {
      await Future<void>.delayed(const Duration(seconds: 10));
      await NotificationService().showNotification(i, 'Eldiyar', 'Sen jakshy adamsyng iygilik kaalaim saga!');
    }
    // while (true) {
    //   await Future<void>.delayed(const Duration(seconds: 3));
    //   await NotificationService().showNotification(1, 'Eldiyar', 'Sen jakshy adamsyng iygilik kaalaim saga!');
    //   continue;
    //   // return Future.value(true);
    // }
    return Future.value(true);
  });
}
