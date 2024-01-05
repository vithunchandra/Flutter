import 'package:flutter/cupertino.dart';

class Album{
  final String name;
  final String mbid;
  final int playcount;
  final String url;
  final String image;
  final String artist;

  Album({
    required this.name,
    required this.mbid,
    required this.url,
    required this.image,
    required this.playcount,
    required this.artist
  });

  factory Album.fromJson(Map<String, dynamic> parsedJson){
    return Album(
        name: parsedJson['name'],
        mbid: parsedJson['mbid'] ?? '',
        url: parsedJson['url'],
        image: parsedJson['image'][3]['#text'],
        playcount: parsedJson['playcount'],
        artist: parsedJson['artist']['name']
    );
  }
}