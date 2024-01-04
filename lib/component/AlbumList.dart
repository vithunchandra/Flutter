import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/class/Track.dart';
import 'package:project/class/AlbumTracks.dart';
import 'package:project/Style.dart';

class AlbumList extends StatefulWidget {
  const AlbumList({super.key});

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/albums.json'),
        builder: (context, snapshot){
          if(snapshot.hasData){
            final response = snapshot.data as String;
            var data = jsonDecode(response) as List;
            List<AlbumTracks> albums = data.map((item) => AlbumTracks.fromJson(item)).toList();
            final albumCards = <Widget>[];
            for(int i=0; i<albums.length; i++){
              albumCards.add(
                  albumCard(albums[i], context,)
              );
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: albumCards,
              ),
            );
          }else{
            return Container();
          }
        }
    );
  }
}

Widget albumCard(AlbumTracks album, BuildContext context){
  return GestureDetector(
    onTap: (){
      Navigator.pushNamed(context, '/album', arguments: {
        'album': album
      });
    },
    child: Container(
      width: 170,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(album.image, fit: BoxFit.cover,),
          Text(
            album.name,
            style: titleStyle()
          ),
          const SizedBox(height: 4,),
          Text(
            album.artist,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
              wordSpacing: 1,
            ),
          )
        ],
      ),
    ),
  );
}