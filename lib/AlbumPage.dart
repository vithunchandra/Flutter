import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/api/client.dart';
import 'package:project/class/Album.dart';
import 'package:project/class/Track.dart';
import 'package:project/Style.dart';
import 'package:project/component/BottomBar.dart';
import 'package:project/component/TrackList.dart';
import 'package:project/provider/playing_track.dart';
import 'package:provider/provider.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late Album album;
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
      var album = data?['album'];
      setState(() {
        futureTracks = fetchTrack(album);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)?.settings.arguments as dynamic;
    album = data?['album'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        foregroundColor: Colors.blueAccent[700],
        title: const Text(
          'Album',
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
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(128, 0, 0, 0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(child: Image.network(album.image, fit: BoxFit.cover,)),
                          const SizedBox(height: 4,),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      album.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                    Text(
                                      album.artist,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey[100]
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                  onPressed: (){},
                                  icon: const Icon(Icons.play_arrow),
                                  iconSize: 35,
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Colors.lime[700])
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Tracks',
                          style: headingStyle(),
                        ),
                        const SizedBox(height: 8,),
                        FutureBuilder(future: futureTracks, builder: (context, snapshot){
                          if(snapshot.hasData){
                            List<Track> tracks = snapshot.data!;
                            return trackList(tracks, context);
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
                        })
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          if(context.watch<PlayingTrack>().playingTrack != null)
            const BottomBar()
        ],
      )
    );
  }

  Future<List<Track>> fetchTrack(Album album) async {
    List<Track> tracks = [];

    var response = await client.get('',
      queryParameters: {
        ...baseParams,
        "method": "album.getinfo",
        "album": album.name,
        "artist": album.artist
      }
    );
    var albumTracks = response.data['album']['tracks']['track'] as List;

    for(int i=0; i<albumTracks.length; i++){
      response = await client.get('',
        queryParameters: {
          ...baseParams,
          "method": "track.getInfo",
          "track": albumTracks[i]['name'],
          "artist": albumTracks[i]['artist']['name']
        }
      );
      tracks.add(Track.fromJson(response.data['track']));
    }
    return tracks;
  }
}