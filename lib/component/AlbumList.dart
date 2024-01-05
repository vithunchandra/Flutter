import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/api/client.dart';
import 'package:project/class/Album.dart';
import 'package:project/class/Track.dart';
import 'package:project/class/AlbumTracks.dart';
import 'package:project/Style.dart';

class AlbumList extends StatefulWidget {
  const AlbumList({super.key});

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  Future<List<Album>>? futureAlbums;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      futureAlbums = fetchAlbum();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureAlbums,
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<Album>? albums = snapshot.data;
            final albumCards = <Widget>[];
            for(int i=0; i<albums!.length; i++){
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
        }
    );
  }

  Future<List<Album>> fetchAlbum() async {
    List<String> artistId = [
      "e0140a67-e4d1-4f13-8a01-364355bee46e",
      "b8a7c51f-362c-4dcb-a259-bc6e0095f0a6",
      "20244d07-534f-4eff-b4d4-930878889970",
      "b49b81cc-d5b7-4bdd-aadb-385df8de69a6",
      "cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493"
    ];
    Dio client = getClient();
    List<Album> albums = [];

    for(int i=0; i<artistId.length; i++){
      dynamic response;
      try{
        response = await client.get('',
            queryParameters: {
              ...baseParams,
              "method": "artist.gettopalbums",
              "mbid": artistId[i],
              "limit": 5,
            }
        );
      }catch(err){
        debugPrint(err.toString());
      }


      var data = response.data['topalbums']['album'];
      List<Album> convertData = [];
      for(int i=0; i<data.length; i++){
        convertData.add(Album.fromJson(data[i]));
      }
      albums = [...albums, ...convertData];
      debugPrint("hellooooo");
    }

    return albums;
  }
}

Widget albumCard(Album album, BuildContext context){
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