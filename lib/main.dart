import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notification_work_manager/fetch_data.dart';
import 'package:workmanager/workmanager.dart';

import 'app.dart';
import 'notification_service.dart';

Future<void> main() async {
  log('message');
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();
  if (Platform.isAndroid) {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    await Workmanager().registerPeriodicTask(
      "task-identifier",
      "simpleTask",
      initialDelay: const Duration(seconds: 15),
      frequency: const Duration(minutes: 15),
    );
  }

  runApp(const MyApp());
}

Future<void> callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    final res = await fetchData();
    res.fold(
      (l) async {
        log(l.toString());
        await NotificationService().showNotification(0, 'Exception1', l.toString());
      },
      (r) async {
        log(r.toString());
        await NotificationService().showNotification(1, r.msg1.title, r.msg1.content);
        await NotificationService().showNotification(2, r.msg2.title, r.msg2.content);
      },
    );

    return Future.value(true);
  });
}

/**
Приветствую, в моем приложении мне нужно отправлять запрос к базе данных 2 раза в день и выдавать уведомление по response.
Проблема в том, что коды Dart, которые я написал, должны работать, даже когда приложение закрыто. Я использовал фоновый сервис workmanager и flutter_local_notifications. В системе Android работает без проблем, а в системе IOS постоянно вызывает проблемы. Как я могу сделать так, чтобы все работало как я хочу как для Android, так и для iOS?

Hello, in my application I need to send a request to the database 2 times a day and issue a notification on the response.
The problem is that the Dart codes I wrote should work even when the app is closed. I used workmanager background service and flutter_local_notifications. On the Android system, it works without problems, but on the IOS system, it constantly causes problems. How can I make things work the way I want for both Android and iOS?

Приветствую вас всех! Я использую workmanager, на системе Android работает нормально, 
а вот с системой iOS у меня постоянно проблемы, есть кто может помочь?
Можете подсказать кто использовал?
[VERBOSE-2:ui_dart_state.cc(198)] Unhandled Exception: PlatformException(unhandledMethod("registerPeriodicTask") error, 
Unhandled method registerPeriodicTask, null, null)  [Я получил эту ошибку]

Hello everyonel! I am using work manager. On the Android system it works fine, but with the iOS system I constantly 
have problems, is there anyone who can help?
Can you tell me who has used?
[VERBOSE-2:ui_dart_state.cc(198)] Unhandled Exception: PlatformException(unhandledMethod("registerPeriodicTask") error, 
Unhandled method registerPeriodicTask, null, null)  [I got this error]
 */
