import 'package:flutter/material.dart';
import 'package:project/class/Track.dart';

class BottomBar extends StatelessWidget {
  final Track track;
  final BuildContext context;
  const BottomBar({super.key, required this.track, required this.context});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.redAccent,
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                track.image,
                width: 55,
                isAntiAlias: true,
                errorBuilder: (BuildContext context, Object exception, StackTrace ?stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    child: const Icon(Icons.error),
                  );
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
                    track.name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    track.playcount.toString(),
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
