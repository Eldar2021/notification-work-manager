import 'dart:developer';
import 'dart:io';

import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      if (Platform.isAndroid) {
        try {
          //check auto-start availability.
          var test = await (isAutoStartAvailable);
          log(test.toString());
          //if available then navigate to auto-start setting page.
          if (test != null && !test) await getAutoStartPermission();
        } on PlatformException catch (e) {
          log(e.toString());
        }
        if (!mounted) return;
      }
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
