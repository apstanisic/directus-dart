import 'dart:async';

import 'package:directus/directus.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sdk = await Directus('http://localhost:8055').init();
  runApp(
    MyApp(
      sdk: sdk,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.sdk,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  final Directus sdk;
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<DirectusUser?> _subscription;

  DirectusUser? user;

  @override
  void initState() {
    super.initState();
    _subscription = widget.sdk.auth.user.listen((event) {
      setState(() {
        user = event;
      });
    });
  }

  Future<void> login() async {
    try {
      final data = <String, Object?>{
        'email': 'test@example.com',
        'password': 'password',
      };
      await widget.sdk.auth.login(data);
    } on DirectusError catch (e) {
      print(e.message);
    }
  }

  Future<void> data() async {
    try {
      final data = await widget.sdk.users.readMany();
      print(data);
    } on DirectusError catch (e) {
      print(e.message);
    }
  }

  Future<void> logout() async {
    try {
      await widget.sdk.auth.logout();
    } on DirectusError catch (e) {
      print(e.message);
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example Directus'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('User: ${user?.id}'),
              TextButton(
                onPressed: login,
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: logout,
                child: const Text('Logout'),
              ),
              TextButton(
                onPressed: data,
                child: const Text('data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
