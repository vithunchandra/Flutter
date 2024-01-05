import 'package:flutter/material.dart';
import 'package:project/class/Track.dart';
import 'package:project/provider/playing_track.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    Track? playingTrack = context.watch<PlayingTrack>().playingTrack;
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.redAccent,
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                playingTrack!.image,
                width: 55,
                isAntiAlias: true,
                errorBuilder: (BuildContext context, Object exception, StackTrace ?stackTrace) {
                  return Image.asset('assets/mockup.jpg', width: 55, isAntiAlias: true);
                },
              ),
            ),
            const SizedBox(width: 8,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    playingTrack!.name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis
                    ),
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    playingTrack!.artist,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[350]
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.pause, size: 30,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
