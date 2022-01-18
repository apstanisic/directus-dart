import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:directus/directus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sdk = await Directus('http://localhost:8055').init();
  print(1);
  try {
    print('w');
    await sdk.auth.login(email: 'test@example.com', password: 'password');
    print('e');
  } catch (e) {
    print('q');
    print(e.toString());
  }
  print(2);
  // await sdk
  final user = await sdk.auth.currentUser?.read();
  print(3);
  print(user);
  runApp(MyApp(sdk));
}

class MyApp extends StatelessWidget {
  final Directus sdk;

  MyApp(this.sdk);

  /// Get posts.
  Future<DirectusListResponse<Map<String, dynamic>>> getPosts() =>
      sdk.items('posts').readMany();

  /// Get settings.
  Future<DirectusResponse<DirectusSettings>> getSettings() =>
      sdk.settings.read();

  Future<dynamic> getReviews() async {
    print('enter');
    try {
      final result = await sdk.items('posts').readMany(
          // query: Query(
          //     limit: 5,
          //     offset: 0,
          //     fields: ['*'],
          //     meta: Meta(filterCount: true, totalCount: true)),
          );

      print('ehere');
      result.data.forEach((project) => print(project));
    } catch (e) {
      print(e);
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Directus Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Directus Example'),
        ),
        body: Center(
          child: FutureBuilder<dynamic>(
            future: getReviews(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return Placeholder();
              final posts = snapshot.data.data;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(posts[index]['title']),
                  trailing: Text(posts[index]['id'].toString()),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
