import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'album.dart';

const apiKey = 'rCvzss9QDofBpBuePpHq5vSpfSSZu7Pu';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Album> albums = [];

  @override
  void initState() {
    super.initState();
    fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Lesson 8"),
      ),
      body: ListView.builder(
        itemCount: albums.length,
        itemBuilder: (_, i) => AlbumCard(album: albums[i]),
      ),
    );
  }

  Future fetchAlbums() async {
    final response = await http.get(
      Uri.parse(
        'https://api.giphy.com/v1/gifs/trending?api_key=rCvzss9QDofBpBuePpHq5vSpfSSZu7Pu&limit=12',
      ),
    );
    print(response.statusCode);
    print(response.body);
    final result = jsonDecode(response.body)['results'] as List<dynamic>;
    final data = result.map((json) {
      return Album.fromJson(json);
    }).toList();
    setState(() {
      albums = data;
    });
  }
}

class AlbumCard extends StatelessWidget {
  final Album album;
  const AlbumCard({
    Key? key,
    required this.album,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(album.imageUrl),
        Text(album.title),
      ],
    );
  }
}
