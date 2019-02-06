import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:audioplayer2/audioplayer2.dart';
import 'package:firebase_storage/firebase_storage.dart'; 
import 'dart:typed_data';
import 'dart:convert';
import "package:firebase_core/firebase_core.dart"; 
import "package:firebase_database/firebase_database.dart"; 
import "package:cloud_firestore/cloud_firestore.dart"; 

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  // List tracks = List(); 

  String _path;
  File _cachedFile;

  // List tracks = ["one", "track1", "track2", "track3", "track4"]; // note: each track button should now be rendered based on tracks within within Firebase database/Firestore 
  var selectedTrack = ""; 

  @override
  initState() { 
    super.initState(); 
  }
  
  onPressed(trackName) async { 
    print(trackName); 
    await downloadFile(trackName); // should replace track2 with trackName which should be the contents(text) of the button 
    print("Playing track "); 
  }

Future<void> play() async {
  final StorageReference  firebaseStorageRef = FirebaseStorage.instance.ref().child("track1.mp3"); //  FirebaseStorage.instance.ref().child("track1.mp3"); 

    AudioPlayer audioPlayer = new AudioPlayer();
    await audioPlayer.play("http://soundbible.com/mp3/airplane-landing_daniel_simion.mp3");
} 

Future<Null> downloadFile(String trackName) async { 
    final Directory tempDir = Directory.systemTemp;
    final File file = File('${tempDir.path}/${trackName}.mp3');
    final StorageReference ref = FirebaseStorage.instance.ref().child('${trackName}.mp3');
    final StorageFileDownloadTask downloadTask = ref.writeToFile(file);
    final int byteNumber = (await downloadTask.future).totalByteCount;
    AudioPlayer audioPlayer = new AudioPlayer(); 
    audioPlayer.play('/data/user/0/com.example.firesound/cache/${trackName}.mp3'); 
} 



Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title:
            Card(
                    child: RaisedButton(child: Text(document['trackName']), 
                    color: Colors.purple, 
                    onPressed: () => onPressed(document['trackName'])), 
                  )
    );
  }

  @override
  Widget build(context) {
    return  Scaffold(
      appBar: AppBar(
        title:  Text("Firesound"),
      ),
      body: 
                    StreamBuilder(
          stream: Firestore.instance.collection("tracks").snapshots(),
          builder: (context, snapshot) { 
            if (!snapshot.hasData) return Text("Loading...");
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index])
              );
        }
        )

    );
  }
}

