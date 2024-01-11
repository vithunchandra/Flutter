import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/class/Track.dart';
import 'package:project/firebase_service/authentication.dart';
import 'package:project/provider/playing_track.dart';
import 'package:provider/provider.dart';

class TrackCard extends StatefulWidget {
  final Track track;
  const TrackCard({super.key, required this.track});

  @override
  State<TrackCard> createState() => _TrackCardState();
}

class _TrackCardState extends State<TrackCard> {
  bool isFavorite = false; // Ganti nilai ini sesuai dengan status favorit dari data Track

  Future<void> insertfavorite() async {
    print("start insrt fav");
    FirebaseFirestore refbaru = FirebaseFirestore.instance;
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    print("2");
    print(uid);
    DocumentReference ref = await refbaru.collection("favorite").add({
      'uid': uid,
      'track_name' : widget.track.name,
      'track_mbid' : widget.track.mbid,
      'track_url' : widget.track.url,
      'track_artist' : widget.track.artist,
      'track_album' : widget.track.album,
      'track_duration' : widget.track.duration,
      'track_image' : widget.track.image,
      'track_listeners' : widget.track.listeners,
      'track_playcount' : widget.track.playcount,

    }).whenComplete(
            () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Add Favorite Is Done"),
        )));
    print("end insrt fav");
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Image.network(
            widget.track.image,
            width: 60,
            isAntiAlias: true,
            errorBuilder: (BuildContext context, Object exception, StackTrace ?stackTrace) {
              return Image.asset('assets/mockup.jpg', width: 60, isAntiAlias: true);
            },
          ),
          const SizedBox(width: 8,),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.track.name,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis
                  ),
                ),
                Text(
                  widget.track.album,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    // Toggle status favorit
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                    insertfavorite();
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 30,
                    color: isFavorite ? Colors.red : null,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<PlayingTrack>().setPlayingTrack(widget.track);
                  },
                  icon: const Icon(Icons.play_arrow, size: 30,),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}