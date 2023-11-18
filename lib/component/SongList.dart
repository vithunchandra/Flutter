import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/Style.dart';
import 'package:project/class/Artist.dart';
import 'package:project/class/Track.dart';

class SongList extends StatefulWidget {
  final dynamic action;
  const SongList({super.key, required this.action});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('assets/artist.json'),
      builder: (context, snapshot){
        if(snapshot.hasData){
          final response = snapshot.data as String;
          var data = jsonDecode(response) as List;
          List<Artist> artists = data.map((item) => Artist.fromJson(item)).toList();

          final songs = <Widget>[];
          for(int i=0; i<artists.length; i++){
            songs.add(songCard(
                artists[i],
                context,
                (Track track){
                  widget.action(track);
                }
            ));
          }

          return Column(
            children: songs,
          );
        }else{
          return Container();
        }
      },
    );
  }
}

Widget songCard(Artist artist, BuildContext context, action){
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
            artist.tracks[0].name,
          style: titleStyle(),
        ),
        const SizedBox(height: 8,),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(artist.tracks[0].image, fit: BoxFit.fill,),
          ),
        ),
        const SizedBox(height: 16,),
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: Image.network(artist.image, fit: BoxFit.fill, width: 60,),
            ),
            const SizedBox(width: 12,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  artist.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),
                ),
                const SizedBox(height: 4,),
                Text(
                  artist.albums[0].name,
                  style: const TextStyle(
                    color: Colors.grey
                  ),
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: (){
                      action(artist.tracks[0]);
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