import 'package:flutter/material.dart';
import 'package:project/Style.dart';
import 'package:project/class/Track.dart';
import 'package:project/component/AlbumList.dart';
import 'package:project/component/ArtistList.dart';
import 'package:project/component/BottomBar.dart';
import 'package:project/component/SongList.dart';
import 'package:project/provider/playing_track.dart';
import 'package:provider/provider.dart';

import 'FavoritePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritePage()),
              );
            },
            child: Row(
              children: [
                Icon(Icons.favorite),
                Text('Favorite'),
              ],
            ),
          ),
        ],

      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: MediaQuery.of(context).size.height * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Best Artist',
                      style: headingStyle(),
                    ),
                    const SizedBox(height: 4,),
                    const ArtistList(),
                    const SizedBox(height:32,),
                    const Text(
                      'Best Albums',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                      ),
                    ),
                    const SizedBox(height: 8,),
                    const AlbumList(),
                    const SizedBox(height: 32,),
                    Text(
                      'Best Songs For You',
                      style: headingStyle(),
                    ),
                    const SongList()
                  ],
                ),
              ),
            ),
            if(context.watch<PlayingTrack>().playingTrack != null)
              const BottomBar()
          ],
        )
      ),
    );
  }
}
