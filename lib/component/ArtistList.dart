import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/Class/Artist.dart';

class ArtistList extends StatefulWidget {
  const ArtistList({super.key});

  @override
  State<ArtistList> createState() => _ArtistListState();
}

class _ArtistListState extends State<ArtistList> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/artist.json'),
        builder: (context, snapshot){
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
            final response = snapshot.data as String;
            var data = jsonDecode(response) as List;
            List<Artist> artists = data.map((i) => Artist.fromJson(i)).toList();

            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: artistCard(artists[0])),
                    const SizedBox(width: 4),
                    Expanded(child: artistCard(artists[1])),
                  ],
                ),
                const SizedBox(height: 4,),
                Row(
                  children: <Widget>[
                    Expanded(child: artistCard(artists[2])),
                    const SizedBox(width: 4),
                    Expanded(child: artistCard(artists[3])),
                  ],
                )
              ],
            );
          }else{
            return Container();
          }
        }
    );
  }
}

Widget artistCard(Artist artist){
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      color: Color.fromARGB(20, 0, 0, 0),
    ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              child: Image.network(artist.image)
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(artist.name),
                Text(artist.listeners.toString())
              ],
            ),
          )
        ],
      )
  );
}
