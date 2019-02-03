import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:audioplayer2/audioplayer2.dart';
import 'package:firebase_storage/firebase_storage.dart'; 
import 'dart:typed_data';
import 'dart:convert';

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
  String _path;
  File _cachedFile;

  List tracks = ["one", "track1", "track2", "track3", "track4"];
  var selectedTrack = ""; 
  
  onPressed() async { 
    await downloadFile('track2'); 
    print("Playing track "); 
  }

Future<void> play() async {
  final StorageReference  firebaseStorageRef = FirebaseStorage.instance.ref().child("track1.mp3"); //  FirebaseStorage.instance.ref().child("track1.mp3"); 

    AudioPlayer audioPlayer = new AudioPlayer();
    await audioPlayer.play("http://soundbible.com/mp3/airplane-landing_daniel_simion.mp3");
} 

Future<Null> downloadFile(String trackName) async { 
    print(trackName); 
    final Directory tempDir = Directory.systemTemp;
    final File file = File('${tempDir.path}/${trackName}.mp3');

    final StorageReference ref = FirebaseStorage.instance.ref().child('${trackName}.mp3');
    final StorageFileDownloadTask downloadTask = ref.writeToFile(file);

    final int byteNumber = (await downloadTask.future).totalByteCount;

    print(byteNumber); 
    AudioPlayer audioPlayer = new AudioPlayer(); 
    print('File: ${file.toString()}'); 
    // await audioPlayer.play("/data/user/0/com.example.firesound/cache/track1.mp3");
    /*  
    file.readAsString().then((String contents) {
        print('Contents: ${contents}'); 
        audioPlayer.play(contents);
    });
    */ 
    // final String p = file.toString(); 
    // print('p : ${p}'); 
    // audioPlayer.play(p); 
    audioPlayer.play('/data/user/0/com.example.firesound/cache/${trackName}.mp3'); 
}

  @override
  Widget build(context) {
    return  Scaffold(
      appBar: AppBar(
        title:  Text("Firesound"),
      ),
      body:  ListView.builder(
        itemCount: tracks == null ? 0 : tracks.length,
        itemBuilder: (context, index) {
          return Card(
            child: RaisedButton(child: Text(tracks[index]), 
            color: Colors.purple, 
            onPressed: onPressed), 
          );
        },
      ),
    );
  }
}