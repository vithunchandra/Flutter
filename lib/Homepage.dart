import 'package:flutter/material.dart';
import 'package:project/Style.dart';
import 'package:project/component/AlbumList.dart';
import 'package:project/component/ArtistList.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        foregroundColor: Colors.blueAccent[700],
        leading: Icon(Icons.album, size: 30, color: Colors.black,),
        title: const Text(
          'MyMusic',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Best Artist',
                style: headingStyle(),
              ),
              SizedBox(height: 4,),
              const ArtistList(),
              const SizedBox(height: 16,),
              const Text(
                  'Best Albums',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),
              ),
              AlbumList(),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
