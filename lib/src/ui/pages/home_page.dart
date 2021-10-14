import 'package:agenda/src/core/controllers/theme_controller.dart';
import 'package:agenda/src/core/services/user_management.dart';
import 'package:agenda/src/ui/pages/usuarios.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'agenda.dart';
import 'new_cita.dart';

class HomePage extends StatefulWidget {
  var loggedUser;
  HomePage(this.loggedUser, {Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState(this.loggedUser);
  UserManagement userManagement = new UserManagement();
}

class _MyHomePageState extends State<HomePage> {
  var loggedUser;
  _MyHomePageState(this.loggedUser);

  GlobalKey<ScaffoldState> homePageKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: ThemeController.instance.brightness,
        builder: (BuildContext context, value, Widget child) {
          return(
            DefaultTabController(
              length: 3,
              child: Scaffold(
                key: homePageKey,
                appBar: AppBar(
                  backgroundColor: Colors.orange,
                  title: Text('Agenda'),
                  actions: <Widget>[
                    IconButton(onPressed: _addCita, //lamamos al metodo add
                        icon: Icon(Icons.wysiwyg_rounded)),
                    IconButton(onPressed: _addUser, //lamamos al metodo add
                        icon: Icon(Icons.person_add)),
                    IconButton(onPressed: _cerrarSession, //lamamos al metodo add
                        icon: Icon(Icons.power_settings_new))
                  ],
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.orange],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft
                      )
                    ),
                  ),
                  elevation: 3,
                  bottom: TabBar(
                    labelColor: Colors.white,
                    tabs: [
                      Tab(text: 'Citas', icon: Icon(Icons.note)),
                      Tab(text: 'Usuarios', icon: Icon(Icons.people)),
                      Tab(text: 'Reportes',icon: Icon(Icons.analytics_sharp)),
                    ],
                  ),
                  //shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(3)),
                  /*leading: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: (){
                    print('DDD');
                  },
                ),*/
                ),
                  body: TabBarView(
                    children: [
                      Agenda('Pagina de Agenda', context),
                      Usuarios('Pagina de Agenda', context),
                      Center (
                        child: Text('En desarrollo...'),
                      )
                    ],
                  )
              ),
            )
          );
    });

  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getAgenda();
  }
  void getAgenda() async{
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('agenda');
    QuerySnapshot agenda = await collectionReference.get();
    if(agenda.docs.length != 0){
      for(var doc in agenda.docs){
        print(doc);
      }
    }
    //_showSnakBar(context, 'Hola', Colors.red);
  }
  void _showSnakBar(BuildContext context, String title, Color backColor){
    homePageKey.currentState.showSnackBar(
        SnackBar(content: Text(
          title,
          textAlign: TextAlign.center,
        ),
          backgroundColor: backColor,
        )
    );
  }

  void _cerrarSession(){
    FirebaseAuth.instance.signOut().then((value)  {
      Navigator.of(context).pushReplacementNamed("/login");
    });
  }
  void _addUser(){
    Navigator.of(context).pushNamed('/register');
  }
  void _addCita(){
    Navigator.push(context,
        MaterialPageRoute(builder: (ct)=>NewCita(null)
        ));
  }
}
