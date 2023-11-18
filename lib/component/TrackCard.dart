import 'package:flutter/material.dart';
import 'package:project/class/Track.dart';

Widget trackCard(Track track, BuildContext context, action){
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: <Widget>[
        Image.network(
          track.image,
          width: 60,
          isAntiAlias: true,
          errorBuilder: (BuildContext context, Object exception, StackTrace ?stackTrace) {
            return Container(
              width: 60,
              height: 60,
              child: Icon(Icons.error),
            );
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
                track.playcount.toString(),
                style: TextStyle(
                    fontSize: 18,
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
              onPressed: action,
              icon: const Icon(Icons.play_arrow, size: 30,),
            ),
          )
        )
      ],
    ),
  );
}