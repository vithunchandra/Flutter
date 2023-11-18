
import 'package:project/class/Album.dart';
import 'package:project/class/Track.dart';

class Artist{
  final String name;
  final String url;
  final String image;
  final int listeners;
  final int playcount;
  final List<Album> albums;
  final List<Track> tracks;

  Artist({
    required this.name,
    required this.url,
    required this.image,
    required this.listeners,
    required this.playcount,
    required this.albums,
    required this.tracks
  });

  factory Artist.fromJson(Map<String, dynamic> parsedJson){
    int listeners = int.parse(parsedJson['stats']['listeners']);
    int playcount = int.parse(parsedJson['stats']['playcount']);
    var albumList = parsedJson['albums'] as List;
    var trackList = parsedJson['tracks'] as List;
    List<Album> albums = albumList.map((i) => Album.fromJson(i)).toList();
    List<Track> tracks = trackList.map((i) => Track.fromJson(i)).toList();

    return Artist(
        name: parsedJson['name'],
        url: parsedJson['url'],
        image: parsedJson['image'],
        listeners: listeners,
        playcount: playcount,
        albums: albums,
        tracks: tracks
    );
  }
}