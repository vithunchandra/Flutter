import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/Style.dart';
import 'package:project/api/client.dart';
import 'package:project/class/Artist.dart';
import 'package:project/class/Track.dart';
import 'package:project/provider/playing_track.dart';
import 'package:provider/provider.dart';

class SongList extends StatefulWidget {
  const SongList({super.key});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  Dio client = getClient();
  Future<List<Track>>? futureTracks;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      futureTracks = fetchSong();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('assets/artist.json'),
      builder: (context, snapshot){
        if(snapshot.hasData){
          final response = snapshot.data as String;
          var data = jsonDecode(response) as List;
          List<Artist> artists = data.map((item) => Artist.fromJson(item)).toList();

          return FutureBuilder(
            future: futureTracks,
            builder: (context, snapshot){
              if(snapshot.hasData){
                List<Track> tracks = snapshot.data!;
                final songs = <Widget>[];
                for(int i=0; i<tracks.length; i++){
                  songs.add(
                      songCard(tracks[i], context)
                  );
                }

                return Column(
                  children: songs,
                );
              }else if(snapshot.hasError){
                return Text(
                  snapshot.error.toString(),
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.red
                  ),
                );
              }

              return const CircularProgressIndicator();
            },
          );
        }else{
          return Container();
        }
      },
    );
  }

  Future<List<Track>> fetchSong() async {
    List<Track> tracks = [];

    var response = await client.get('',
      queryParameters: {
        ...baseParams,
        'method': 'chart.gettoptracks'
      }
    );
    var tempTracks = response.data['tracks']['track'] as List;

    for(int i=0; i<tempTracks.length; i++){
      response = await client.get('',
        queryParameters: {
          ...baseParams,
          "method": "track.getInfo",
          "track": tempTracks[i]['name'],
          "artist": tempTracks[i]['artist']['name']
        }
      );
      tracks.add(Track.fromJson(response.data['track']));
    }
    return tracks;
  }
}

Widget songCard(Track track, BuildContext context){
  return Container(
    decoration: BoxDecoration(
      color: const Color.fromARGB(150, 120, 199, 25),
      borderRadius: BorderRadius.circular(8)
    ),
    margin: const EdgeInsets.symmetric(vertical: 12),
    height: MediaQuery.of(context).size.height * 0.55,
    width: MediaQuery.of(context).size.width * 1,
    padding: const EdgeInsets.all(16),
    child: Column(
      children: <Widget>[
        Text(
          track.name,
          style: titleStyle(),
        ),
        const SizedBox(height: 8,),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: track.image.isEmpty ? Image.asset('assets/mockup.jpg', fit: BoxFit.fill) : Image.network(track.image, fit: BoxFit.fill,),
          ),
        ),
        const SizedBox(height: 16,),
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: track.image.isEmpty ? Image.asset('assets/mockup.jpg', fit: BoxFit.fill, width: 60) : Image.network(track.image, fit: BoxFit.fill, width: 60,),
            ),
            const SizedBox(width: 12,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    track.artist,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
                const SizedBox(height: 4,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    track.album,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: (){
                      context.read<PlayingTrack>().setPlayingTrack(track);
                    },
                    icon: const Icon(Icons.play_arrow),
                  iconSize: 35,
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.lime[600])
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    ),
  );
}