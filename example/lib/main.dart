import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:directus/directus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final sdk = await Directus('http://localhost:8055').init();
  await sdk.auth.login(email: 'test@example.com', password: 'password');
  // await sdk
  final user = await sdk.auth.currentUser.read();
  print(user);
  runApp(MyApp(sdk));
}

class MyApp extends StatelessWidget {
  final Directus sdk;

  MyApp(this.sdk);

  /// Get posts.
  Future<DirectusListResponse<Map<String, dynamic>>> getPosts() => sdk.items('posts').readMany();

  /// Get settings.
  Future<DirectusResponse<DirectusSettings>> getSettings() => sdk.settings.read();

  Future<dynamic> getReviews() async {
    sdk.custom.options.headers['Custom-Header'] = 'some-value';
    final result = await sdk.items('reviews').readMany(
        query: Query(
            limit: 5, offset: 0, fields: ['*'], meta: Meta(filterCount: true, totalCount: true)),
        filters: Filters({'is_positive': Filter.eq(false)}));

    result.data.forEach((project) => print(project['title']));
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
