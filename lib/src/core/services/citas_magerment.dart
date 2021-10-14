import 'package:agenda/src/core/models/cita.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

class CitaManagerment{
  addCita(Cita cita, BuildContext context){
    FirebaseFirestore.instance.collection('/citas')
        .add({
      'empresa': cita.empresa,
      'detalles': cita.detalles,
      'fecha': cita.fecha,
      'fecha_registrada': DateTime.now()
    }).then((value) {
      Toast.show('Registro guardado correctamente...', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.of(context).maybePop();
    }).catchError((e){
      print(e);
    });
  }
  updateCita(Cita cita, BuildContext context){
    FirebaseFirestore.instance.collection('/citas').doc(cita.id)
    .update({
      'empresa': cita.empresa,
      'detalles': cita.detalles,
      'fecha': cita.fecha,
    }).then((value){
      Toast.show('Editado correctamente...', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.of(context).maybePop();
    }).catchError((e){
      Toast.show('Ocurrio un error!', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    });
  }
  deleteCita(String id, BuildContext context){
    FirebaseFirestore.instance.collection('/citas').doc(id)
        .delete().then((value){
      Toast.show('Editado correctamente...', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.of(context).maybePop();
    }).catchError((e){
      Toast.show('Ocurrio un error!', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    });
  }
}