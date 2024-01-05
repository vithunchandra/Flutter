import 'package:flutter/material.dart';
import 'package:project/class/Track.dart';
import 'package:project/provider/playing_track.dart';
import 'package:provider/provider.dart';

Widget trackCard(Track track, BuildContext context){
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: <Widget>[
        Image.network(
          track.image,
          width: 60,
          isAntiAlias: true,
          errorBuilder: (BuildContext context, Object exception, StackTrace ?stackTrace) {
            return Image.asset('assets/mockup.jpg', width: 60, isAntiAlias: true);
          },
        ),
        const SizedBox(width: 8,),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                track.name,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis
                ),
              ),
              Text(
                track.album,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: (){
                context.read<PlayingTrack>().setPlayingTrack(track);
              },
              icon: const Icon(Icons.play_arrow, size: 30,),
            ),
          )
        )
      ],
    ),
  );
}