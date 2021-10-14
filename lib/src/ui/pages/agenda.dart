import 'package:agenda/src/core/models/cita.dart';
import 'package:agenda/src/core/services/citas_magerment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import 'new_cita.dart';

class Agenda extends StatefulWidget {
  String pagina;
  BuildContext context;
  Agenda(this.pagina, this.context, {Key key}) : super(key: key);
  PageState createState() => PageState();
}

class PageState extends State<Agenda> {

  List<Cita> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('citas').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Center(
              child: CircularProgressIndicator(),
            ));
          } else {
            list = [];
            for (var doc in snapshot.data.docs) {
              //print(doc['fecha'].toDate());
              //print(doc['fecha_registrada'].toString());
              list.add(Cita(doc.id, doc['empresa'], doc['detalles'], doc['fecha'].toDate(), doc['fecha_registrada'].toDate()));
            }
            return Center(
              child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                        key: ValueKey(index),
                        actionPane: SlidableDrawerActionPane(),
                        secondaryActions: [
                          IconSlideAction(
                            caption: 'Editar',
                            color: Colors.blue,
                            icon: Icons.edit,
                            closeOnTap: true,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (ct)=>NewCita(list[index])
                                  ));
                            },
                          ),
                          IconSlideAction(
                            caption: 'Eliminar',
                            color: Colors.red.shade700,
                            icon: Icons.delete,
                            closeOnTap: true,
                            onTap: () {
                              _msgDelete(context, list[index].id);
                            },
                          )
                        ],
                        dismissal:
                            SlidableDismissal(child: SlidableDrawerDismissal()),
                        child: ListTile(
                          title: Text(list[index].empresa),
                          subtitle: Text(list[index].detalles),
                          leading: Icon(Icons.note),
                          trailing: Text(getDate(list[index].fecha)),
                        ));
                  }),
            );
          }
        },
      ),
    );
  }
  String getDate(DateTime date){
    DateTime d = new DateTime.now();
    if(d.year == date.year && d.month == date.month && d.day == date.day){
      return 'Hoy a las ${date.hour}:${date.month}';
    }else{
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }
  void _msgDelete(BuildContext context, String id){
    showDialog(context: context,
        builder:(BuildContext c){
          return AlertDialog(
            title: Text('Advertencia?'),
            content: Text('Desea eliminar el registro?'),
            actions: [
              FlatButton(onPressed: (){
                Navigator.pop(c);
              }, child: Text('NO')),
              FlatButton(onPressed: (){
                Navigator.pop(c);
                Toast.show('Ejecutando...', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                CitaManagerment citaM = new CitaManagerment();
                citaM.deleteCita(id, context);
                }, child: Text('SI'))
            ],
          );
        }
    );
  }
}
