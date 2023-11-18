import 'package:project/class/Album.dart';
import 'package:project/class/Track.dart';

class AlbumTracks extends Album{
  final List<Track> tracks;
  final String artist;

  AlbumTracks({
    required this.tracks,
    required this.artist,
    required super.name,
    required super.url,
    required super.image,
    required super.playcount
  });

  factory AlbumTracks.fromJson(Map<String, dynamic> parsedJson){
    var trackList = parsedJson['tracks'] as List;
    List<Track> tracks = trackList.map((i) => Track.fromJson(i)).toList();
    return AlbumTracks(
        tracks: tracks,
        artist: parsedJson['artist'],
        name: parsedJson['name'],
        url: parsedJson['url'],
        image: parsedJson['image'][2]['#text'],
        playcount: int.parse(parsedJson['playcount'])
    );
  }
}