import 'package:agenda/src/core/models/cita.dart';
import 'package:agenda/src/core/services/citas_magerment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewCita extends StatefulWidget {
  final Cita cita;
  NewCita(this.cita);
  PageState createState() => PageState(cita);
}

class PageState extends State<NewCita> {
  Cita _cita;
  PageState(this._cita);
  final _formKey = GlobalKey<FormState>();
  final _fechaController = TextEditingController();
  final _horaController = TextEditingController();
  CitaManagerment _citaManagerment = new CitaManagerment();

  String _detalles;
  String _empresa;
  DateTime _dateTime;
  TimeOfDay _time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registrar Nueva cita'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepOrange, Colors.orange],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft)),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    enabled: false,
                                    controller: _fechaController,
                                    decoration: InputDecoration(labelText: 'Fecha'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Seleccione la fecha';
                                      }
                                    },
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: _dateTime == null
                                                  ? DateTime.now()
                                                  : _dateTime,
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2222))
                                          .then((date) {
                                        setState(() {
                                          _fechaController.text =
                                              getFormatedDate(date);
                                          _dateTime = date;
                                        });
                                        //_fechaController.text = getFormatedDate(date);
                                      });
                                    },
                                    icon: Icon(Icons.date_range_outlined))
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    enabled: false,
                                    controller: _horaController,
                                    decoration: InputDecoration(labelText: 'Hora'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Seleccione la hora';
                                      }
                                    },
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: _time == null
                                                  ? TimeOfDay.now()
                                                  : _time)
                                          .then((value) {
                                        setState(() {
                                          _time = value;
                                          _horaController.text =
                                              '${value.hour}:${value.minute}';
                                        });
                                      });
                                    },
                                    icon: Icon(Icons.access_time_outlined))
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          child: TextFormField(
                            //keyboardType: TextInputType.number,
                            initialValue: _empresa,
                            decoration: InputDecoration(labelText: 'Empresa'),
                            onSaved: (value) {
                              _empresa = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          child: TextFormField(
                            //keyboardType: TextInputType.number,
                            initialValue: _detalles,
                            decoration: InputDecoration(labelText: 'Detalles'),
                            onSaved: (value) {
                              _detalles = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RaisedButton(
                                  child: Text("Cancelar"),
                                  onPressed: () {
                                    Navigator.of(context).maybePop();
                                  }),
                              //Expanded(child: Text('')),
                              RaisedButton(
                                  child: Text("Guardar"),
                                  color: Colors.orange,
                                  focusElevation: 7,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    _saveCita(context);
                                  })
                            ],
                          ),
                        ),
                      ]
                    )
                )
            )
        )
    );
  }

  _saveCita(BuildContext context) {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      print(_dateTime);
      print(_time.minute);
      var date = DateTime.parse('${_dateTime.year}-'
          '${(_dateTime.month < 10 ? '0${_dateTime.month}' : _dateTime.month)}'
          '-${(_dateTime.day < 10 ? '0${_dateTime.day}' : _dateTime.day)} '
          '${(_time.hour < 10 ? '0${_time.hour}' : _time.hour)}:'
          '${(_time.minute < 10 ? '0${_time.minute}' : _time.minute)}:00');
      print(date);
      if(_cita == null) _citaManagerment.addCita(Cita(null, _empresa, _detalles, date, null), context);
      else _citaManagerment.updateCita(Cita(_cita.id, _empresa, _detalles, date, null), context);
    }
  }

  getFormatedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(_cita != null){
      _empresa = _cita.empresa;
      _detalles = _cita.detalles;
      _dateTime = _cita.fecha;
      _time = TimeOfDay(hour: _cita.fecha.hour, minute: _cita.fecha.minute);
      _fechaController.text = '${_cita.fecha.day}/${_cita.fecha.month}/${_cita.fecha.year}';
      _horaController.text = '${_cita.fecha.hour}:${_cita.fecha.hour}';
      //_empresa = _cita.empresa;
      //_empresa = _cita.empresa;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //_fechaController.dispose();
  }
}
