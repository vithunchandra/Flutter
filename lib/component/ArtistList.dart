import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/class/Artist.dart';
import 'package:project/class/Track.dart';

class ArtistList extends StatefulWidget {
  final dynamic setPlayedTrack;
  final Track? playedTrack;
  const ArtistList({super.key, required this.setPlayedTrack, required this.playedTrack});


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
                    Expanded(child: artistCard(artists[0], context, widget.playedTrack, widget.setPlayedTrack),),
                    const SizedBox(width: 8),
                    Expanded(child: artistCard(artists[1], context, widget.playedTrack, widget.setPlayedTrack)),
                  ],
                ),
                const SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                    Expanded(child: artistCard(artists[2], context, widget.playedTrack, widget.setPlayedTrack)),
                    const SizedBox(width: 8),
                    Expanded(child: artistCard(artists[3], context, widget.playedTrack, widget.setPlayedTrack)),
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

Widget artistCard(Artist artist, BuildContext context, Track? playedTrack, setPlayedTrack){
  return GestureDetector(
    onTap: () async{
      var result = await Navigator.pushNamed(context, '/artist', arguments: {
        'artist': artist,
        'playedTrack': playedTrack
      });
      setPlayedTrack(result);
    },
    child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Color.fromARGB(20, 0, 0, 0),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
                  child: Image.network(artist.image)
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      artist.name,
                      style:const TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.people, size: 20,),
                        const SizedBox(width: 4,),
                        Text(artist.listeners.toString())
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )
    ),
  );
}
