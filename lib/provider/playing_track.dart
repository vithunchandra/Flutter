import 'package:flutter/material.dart';
import 'package:project/class/Track.dart';

class PlayingTrack with ChangeNotifier{
  Track? playingTrack;

  void setPlayingTrack(Track track){
    playingTrack = track;
    notifyListeners();
  }

  void unsetPlayingTrack(){
    playingTrack = null;
    notifyListeners();
  }
}