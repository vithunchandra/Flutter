
import 'package:project/class/Album.dart';
import 'package:project/class/Track.dart';

class Artist{
  final String name;
  final String mbid;
  final String url;
  final String image;
  final int listeners;
  final int playcount;

  Artist({
    required this.name,
    required this.mbid,
    required this.url,
    required this.image,
    required this.listeners,
    required this.playcount
  });

  factory Artist.fromJson(Map<String, dynamic> parsedJson){
    int listeners = int.parse(parsedJson['stats']['listeners']);
    int playcount = int.parse(parsedJson['stats']['playcount']);

    return Artist(
        name: parsedJson['name'],
        mbid: parsedJson['mbid'],
        url: parsedJson['url'],
        image: parsedJson['image'],
        listeners: listeners,
        playcount: playcount,
    );
  }
}