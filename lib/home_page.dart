import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Map<Permission, PermissionStatus> statuses = await [
      //   Permission.notification,
      //   Permission.ignoreBatteryOptimizations,
      //   // Permission.ignoreBatteryOptimizations,
      // ].request();
      // log(statuses.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
      ),
      body: const Center(
        child: Text('HomeView'),
      ),
    );
  }
}
