import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:directus/directus.dart';

void main() async {
  final sdk = await Directus('http://localhost:8055').init();
  runApp(MyApp(sdk));
}

class MyApp extends StatelessWidget {
  final Directus sdk;

  MyApp(this.sdk) {
    getImage().then((value) => print(value));
  }

// initSta
  // initState() {
  //   super.initState();
  //   getImage();
  // }

  /// Get posts.
  Future<DirectusListResponse<Map<String, dynamic>>> getPosts() => sdk.items('posts').readMany();

  /// Get settings.
  Future<DirectusResponse<DirectusSettings>> getSettings() => sdk.settings.read();

  /// Get image
  Future<dynamic> getImage() async {
    // final response = await sdk.files.getFile('8be97980-bb1e-48d4-9b81-6374cbf58f6f');
    sdk.client
        .get('/assets/8be97980-bb1e-48d4-9b81-6374cbf58f6f')
        .then((value) => print((File(value.data).hashCode)));
    // return Image.network('src');
    // print('response');
    // print(response);
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
            future: getImage(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print(snapshot.data);
              }
              return Container();
              // if (!snapshot.hasData) {
              //   return Container();
              // }
              // final posts = snapshot.data.data;
              // return ListView.builder(
              //   itemCount: posts.length,
              //   itemBuilder: (context, index) => ListTile(
              //     title: Text(posts[index]['title']),
              //     trailing: Text(posts[index]['id'].toString()),
              //   ),
              // );
            },
          ),
        ),
      ),
    );
  }
}
