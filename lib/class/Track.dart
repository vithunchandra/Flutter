import 'package:flutter/cupertino.dart';

class Track{
  final String name;
  final String mbid;
  final String url;
  final String artist;
  final String album;
  final int duration;
  final String image;
  final int listeners;
  final int playcount;

  Track({
    required this.name,
    required this.mbid,
    required this.playcount,
    required this.duration,
    required this.image,
    required this.listeners,
    required this.url,
    required this.artist,
    required this.album
  });

  factory Track.fromJson(dynamic parsedJson){
    int duration = int.parse(parsedJson['duration'] ?? '0');
    int listeners = int.parse(parsedJson['listeners'] ?? '0');
    int playcount = int.parse(parsedJson['playcount'] ?? '0');
    dynamic album = parsedJson['album'];
    String image = album != null ? parsedJson['album']['image'][2]['#text'] : '';
    String title = album != null ? album['title'] : '';
    return Track(
        name: parsedJson['name'] ?? '"No Name"',
        mbid: parsedJson['mbid'] ?? '',
        playcount: playcount,
        duration: duration,
        image: image,
        listeners: listeners,
        url: parsedJson['url'] ?? '',
        artist: parsedJson['artist']['name'],
        album: title
    );
  }
}