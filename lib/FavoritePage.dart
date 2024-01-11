import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'class/Track.dart';

class FavoritePage extends StatelessWidget {

  Future<void> hapus(String uid, String trackName) async {
    try {
      await FirebaseFirestore.instance
          .collection("favorite")
          .where('uid', isEqualTo: uid)
          .where('track_name', isEqualTo: trackName)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });

      print("Document deleted");
    } catch (e) {
      print("Error deleting document: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Tracks'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("favorite")
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No favorite tracks yet.'),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

              print(data);
              print("cek id disini");
              print(data['id'].toString());
              print(data['doc_id'].toString());
              print(data['documentID'].toString());
              // Create Track object from data
              Track favoriteTrack = Track(
                name: data['track_name'],
                mbid: data['track_mbid'],
                url: data['track_url'],
                artist: data['track_artist'],
                album: data['track_album'],
                duration: data['track_duration'],
                image: data['track_image'],
                listeners: data['track_listeners'],
                playcount: data['track_playcount'],
              );

              return ListTile(
                leading: Image.network(
                  favoriteTrack.image,
                  width: 90,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                title: Text(favoriteTrack.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(favoriteTrack.album),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          hapus(data['uid'], data['track_name']);
                        },
                        child: Text("Hapus"),
                      ),
                    ),
                  ],
                ),
                // Add more widgets to display other information about the track
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
