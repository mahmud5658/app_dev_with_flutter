import 'package:assignment/screen/imageDetails.dart';
import 'package:assignment/widgets/app_bar.dart';
import 'package:assignment/widgets/photo.dart';
import 'package:assignment/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Photo>> futurePhotos;

  Future<List<Photo>> fetchPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  void initState() {
    super.initState();
    futurePhotos = fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const appBar(title: "Photo Gallery App"),
      body: FutureBuilder<List<Photo>>(
        future: futurePhotos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Photo photo = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          navigation.navigationMaterialRoute(
                              context,
                              details(
                                url: photo.thumbnailUrl,
                                title: photo.title,
                                Id: photo.id,
                              ));
                        },
                        child: SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network(photo.thumbnailUrl)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            photo.title,
                            style: const TextStyle(fontSize: 16),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
