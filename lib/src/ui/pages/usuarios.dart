import 'package:agenda/src/core/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Usuarios extends StatefulWidget{
  String pagina;
  BuildContext context;
  Usuarios(this.pagina, this.context, {Key key}) : super(key: key);
  PageState createState() => PageState();
}

class PageState extends State<Usuarios> {
  List<Usuario> list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ));
          }else{
            list = [];
            for(var doc in snapshot.data.docs){
              list.add(Usuario(doc.id, doc['name'], doc['email']));
            }
            return Center(
              child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text(list[index].nombre),
                        subtitle: Text(list[index].email),
                        leading: Icon(Icons.person),
                        trailing: Icon(Icons.edit),
                        onTap:(){
                          /*Navigator.push(context,
                              MaterialPageRoute(builder: (ct)=>NewCita(null)
                              ));*/
                        }
                    );
                  }
              ),
            );
          }
        },
      ),
    );
  }
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    //getUsuarios();
  }
  void getUsuarios() async{
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('user');
    QuerySnapshot agenda = await collectionReference.get();
    if(agenda.docs.length != 0){
      for(var doc in agenda.docs){
        print(doc);
        //_users.add(Usuario());
      }
    }
    //_showSnakBar(context, 'Hola', Colors.red);
  }
}