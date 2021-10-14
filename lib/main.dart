import 'package:agenda/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value){
    runApp(MyApp());
  });
}

//ERROR Version KOTLIN
//https://www.youtube.com/watch?v=fQYMi_GZ0Dk