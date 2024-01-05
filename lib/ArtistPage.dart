import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/api/client.dart';
import 'package:project/class/Album.dart';
import 'package:project/class/Artist.dart';
import 'package:project/class/Track.dart';
import 'package:project/Style.dart';
import 'package:project/component/BottomBar.dart';
import 'package:project/component/TrackList.dart';
import 'package:project/provider/playing_track.dart';
import 'package:provider/provider.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({super.key});

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  late Artist artist;
  Future<List<Album>>? futureAlbums;
  Future<List<Track>>? futureTracks;
  Dio client = getClient();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // future that allows us to access context. function is called inside the future
    // otherwise it would be skipped and args would return null
    Future.delayed(Duration.zero, () {
      var data = ModalRoute.of(context)?.settings.arguments as dynamic;
      var artist = data?['artist'];
      setState(() {
        futureAlbums = fetchAlbum(artist);
        futureTracks = fetchTrack(artist);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)?.settings.arguments as dynamic;
    artist = data?['artist'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        foregroundColor: Colors.blueAccent[700],
        title: const Text(
          'Artist',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ArtistImage(artist, context),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.people, size: 25,),
                                    const SizedBox(width: 4,),
                                    Text(
                                      artist.listeners.toString(),
                                      style: const TextStyle(
                                          fontSize: 16
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 4,),
                                OutlinedButton(
                                  onPressed: (){},
                                  style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)
                                      )
                                  ),
                                  child: const Text('Follow'),
                                )
                              ],
                            ),
                            IconButton(
                              onPressed: (){},
                              icon: const Icon(Icons.play_arrow, size: 40,),
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.lime[700]
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 24,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Popular Album', style: headingStyle(),),
                        ),
                        const SizedBox(height: 8,),
                        FutureBuilder(future: futureAlbums, builder: (context, snapshot){
                          if(snapshot.hasData){
                            List<Album> albums = snapshot.data!;
                            return popularAlbum(albums);
                          }else if(snapshot.hasError){
                            return Text(
                              snapshot.error.toString(),
                              style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.red
                              ),
                            );
                          }
                          return const CircularProgressIndicator();
                        }),
                        const SizedBox(height: 24,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Popular Songs', style: headingStyle(),),
                        ),
                        const SizedBox(height: 8,),
                        FutureBuilder(future: futureTracks, builder: (context, snapshot){
                          if(snapshot.hasData){
                            List<Track> artistTracks = snapshot.data!;
                            return trackList(artistTracks, context);
                          }else if(snapshot.hasError){
                            return Text(
                              snapshot.error.toString(),
                              style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.red
                              ),
                            );
                          }

                          return const CircularProgressIndicator();
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(context.watch<PlayingTrack>().playingTrack != null)
            const BottomBar()
        ],
      ),
    );
  }

  Future<List<Album>> fetchAlbum(Artist artist) async {
    List<Album> albums = [];

    final response = await client.get('',
        queryParameters: {
          ...baseParams,
          "method": "artist.gettopalbums",
          "mbid": artist.mbid
        }
    );

    var data = response.data['topalbums']['album'] as List;
    albums = data.map((item) => Album.fromJson(item)).toList();

    return albums;
  }

  Future<List<Track>> fetchTrack(Artist artist) async {
    List<Track> tracks = [];

    var response = await client.get('',
      queryParameters: {
        ...baseParams,
        "method": "artist.gettoptracks",
        "mbid": artist.mbid
      }
    );
    var tempTracks = response.data['toptracks']['track'] as List;

    for(int i=0; i<tempTracks.length; i++){
      response = await client.get('',
        queryParameters: {
          ...baseParams,
          "method": "track.getInfo",
          "track": tempTracks[i]['name'],
          "artist": artist.name
        }
      );
      tracks.add(Track.fromJson(response.data['track']));
    }
    return tracks;
  }
}

Widget popularAlbum(List<Album> albums){
  List<Widget> albumCards = <Widget>[];
  for(int i=0; i<albums.length; i++){
    albumCards.add(albumCard(albums[i]));
  }

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: albumCards,
    ),
  );
}

Widget albumCard(Album album){
  return Container(
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
          album.playcount.toString(),
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
            wordSpacing: 1,
          ),
        )
      ],
    ),
  );
}

Widget ArtistImage(Artist artist, BuildContext context){
  return Stack(
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              image: NetworkImage(artist.image),
            ),
            color: Color.fromARGB(255, 0, 0, 0)
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
            color: Color.fromARGB(75, 0, 0, 0)
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                artist.name,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[100]
                ),
              ),
            ),
          ],
        ),
      )
    ],
  );
}