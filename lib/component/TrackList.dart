import 'package:flutter/material.dart';
import 'package:project/class/Track.dart';
import 'package:project/component/TrackCard.dart';

Widget trackList(List<Track> tracks, BuildContext context, setState){
  List<Widget> tracksCard = <Widget>[];
  for(int i=0; i<tracks.length; i++){
    tracksCard.add(trackCard(tracks[i], context, (){
      setState(tracks[i]);
    }));
  }

  return Column(
    children: tracksCard,
  );
}
