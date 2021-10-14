import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserManagement{
  UserManagement();
  storeNewUser(email, uid, name, context){
    FirebaseFirestore.instance.collection('/users')
        .doc(uid).set({'email': email, 'name': name
    }).then((value) {
      Navigator.pop(context);
      /*Navigator.of(context).pushReplacementNamed("/login", arguments: {
        'email': email, 'uid': uid, 'name': name
      });*/
    }).catchError((e){
      print(e);
    });
  }
  getUser() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    return await auth.currentUser;
  }
}