import 'package:flutter/material.dart';
import 'package:project/class/Track.dart';
import 'package:project/Style.dart';
import 'package:project/class/AlbumTracks.dart';
import 'package:project/component/BottomBar.dart';
import 'package:project/component/TrackList.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late AlbumTracks album;
  Track? playedTrack = null;

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)?.settings.arguments as dynamic;
    album = data?['album'];
    playedTrack = playedTrack ?? data?['playedTrack'];
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
      body: WillPopScope(
        onWillPop: (){
          Navigator.pop(context, playedTrack);
          return Future(() => false);
        },
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
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
                        trackList(album.tracks, context, (Track track){
                          setState(() {
                            playedTrack = track;
                          });
                        })
                      ],
                    ),
                  )
                ],
              ),
            ),
            if(playedTrack != null)
              BottomBar(track: playedTrack!, context: context)
          ],
        )
      )
    );
  }
}