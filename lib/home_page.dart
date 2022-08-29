import 'dart:developer';

import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:flutter/material.dart';

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
      log('bastaldy');
      await getAutoStartPermission();
      // await NotificationService().requestPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {},
            child: const Text('Open App Settings'),
          ),
        ],
      ),
    );
  }
}
