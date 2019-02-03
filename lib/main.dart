import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
// import 'dart:typed_data';
import 'package:audioplayer2/audioplayer2.dart';
import 'package:firebase_storage/firebase_storage.dart'; 
import 'dart:math';

import 'dart:typed_data';
//import 'dart:io';
//import 'dart:async';

/* 

Flutter Firesound: TODO: EMAIL CURRENT "main.dart" code to self 
1. complete Funfunfunction's Haskell playlist - done 
	- may help to watch https://www.youtube.com/watch?v=BMUiFMZr7vk&list=PL0zVEGEvSaeEd9hlmCXrk5yUyqUag-n84 
2. setup Flutter - done 
3. render a list of buttonss - done 
5. set up audioplayer/s - success 
6. play sound (dont forget to configure pubspec.yaml) - success 
	- the asset is instead obtained via HTTP URL 
	- await audioPlayer.play("http://soundbible.com/mp3/airplane-landing_daniel_simion.mp3");
7. connect to firebase - in progress (had to use old firebase_storage version) 
8. play sound obtained from firebase - 
	- https://www.youtube.com/watch?v=iu3a0kf6-Fw 
9. play sound obtained from firebase on [appropriate] button press 
10. ensure code is ready to be commited to BH0's public Github repository 
11. push code to public Github repository 
*/ 

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
    // /play the audio file with the name matching the text within the pressed  button 
    // play(); 
    // await downloadFile(_path); // _path is coming from the state 
    await downloadFile(); // _path is coming from the state 
    print("Playing track "); 
  }

Future<void> play() async {
  final StorageReference  firebaseStorageRef = FirebaseStorage.instance.ref().child("track1.mp3"); //  FirebaseStorage.instance.ref().child("track1.mp3"); 

    AudioPlayer audioPlayer = new AudioPlayer();
    await audioPlayer.play("http://soundbible.com/mp3/airplane-landing_daniel_simion.mp3");
    // await audioPlayer.play("https://soundbible.com/mp3/airplane-landing_daniel_simion.mp3");
    // setState(() => playerState = PlayerState.playing);
} 

// Future<Null> downloadFile(String httpPath) async { 
Future<Null> downloadFile() async { 
/*
  final RegExp regExp = RegExp('([^?/]*\.(jpg))');
  final String fileName = regExp.stringMatch(httpPath); 
  final Directory tempDir = Directory.systemTemp; 
  final File file = File('${tempDir.path}/$fileName'); 

  final StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
  final StorageFileDownloadTask downloadTask = ref.writeToFile(file);

  final int byteNumber = (await downloadTask.future).totalByteCount;
  print(byteNumber); 
  setState(() => _cachedFile = file);

  */

  //  final RegExp regExp = RegExp('([^?/]*\.(jpg))');
  /* 
  final String fileName = regExp.stringMatch("track1.mp3");
  final Directory tempDir = Directory.systemTemp;
  final File file = File('${tempDir.path}/$fileName');

    final StorageReference ref = FirebaseStorage.instance.ref().child("track3.mp4");
    final StorageFileDownloadTask downloadTask = ref.writeToFile(file);

    final int byteNumber = (await downloadTask.future).totalByteCount;

    print(byteNumber);

    setState(() => _cachedFile = file);
  */ 
  final Directory tempDir = Directory.systemTemp;
  final File file = File("track1.mp3");

  final StorageReference ref = FirebaseStorage.instance.ref().child("track1.mp3");
  final StorageFileDownloadTask downloadTask = ref.writeToFile(file);

  AudioPlayer audioPlayer = new AudioPlayer();
  //await audioPlayer.play(_cachedFile.path);
  await audioPlayer.play("track1.mp3"); 
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