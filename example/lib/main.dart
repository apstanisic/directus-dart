import 'package:flutter/material.dart';
import 'package:directus/directus.dart';

void main() async {
  final sdk = await Directus('http://localhost:8055').init();
  runApp(MyApp(sdk));
}

class MyApp extends StatelessWidget {
  final DirectusSdk sdk;

  MyApp(this.sdk);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Directus Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Directus Example'),
        ),
        body: Center(
          child: FutureBuilder<DirectusListResponse<Map<String, dynamic>>>(
            future: sdk.items('posts').readMany(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
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
