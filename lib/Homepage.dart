import 'package:flutter/material.dart';
import 'package:project/Style.dart';
import 'package:project/class/Track.dart';
import 'package:project/component/AlbumList.dart';
import 'package:project/component/ArtistList.dart';
import 'package:project/component/BottomBar.dart';
import 'package:project/component/SongList.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Track? playedTrack = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        foregroundColor: Colors.blueAccent[700],
        leading: const Icon(Icons.album, size: 30, color: Colors.black,),
        title: const Text(
          'MyMusic',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Best Artist',
                      style: headingStyle(),
                    ),
                    const SizedBox(height: 4,),
                    ArtistList(
                      setPlayedTrack: (Track track){
                        setState(() {
                          playedTrack = track;
                        });
                      },
                      playedTrack: playedTrack,
                    ),
                    const SizedBox(height:32,),
                    const Text(
                      'Best Albums',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                      ),
                    ),
                    const SizedBox(height: 8,),
                    AlbumList(
                      setPlayedTrack: (Track track){
                        setState(() {
                          playedTrack = track;
                        });
                      },
                      playedTrack: playedTrack,
                    ),
                    const SizedBox(height: 32,),
                    Text(
                      'Best Songs For You',
                      style: headingStyle(),
                    ),
                    SongList(
                      action: (Track track){
                        setState(() {
                          playedTrack = track;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            if(playedTrack != null)
              BottomBar(track: playedTrack!, context: context)
          ],
        )
      ),
    );
  }
}
