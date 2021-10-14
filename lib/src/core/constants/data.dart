import 'dart:core';

class Constants{
  static const Map<int, String> NAME_MONTH = {
    1: 'Enero',
    2: 'Febrero',
    3: 'Marzo',
    4: 'Abril',
    5: 'Mayo',
    6: 'Junio',
    7: 'Julio',
    8: 'Agosto',
    9: 'Septiembre',
    10: 'Octubre',
    11: 'Noviembre',
    12: 'Diciembre'
  };
  
  static const Map<int, String> NAME_DAYS = {
    1: 'Domingo',
    2: 'Lunes',
    3: 'Martes',
    4: 'Miercoles',
    5: 'Jueves',
    6: 'Viernes',
    7: 'Sábado'
  };

  static const Map<String, String> HEADERS = {
    "content-type": "aplication-json"
  };
  static const String MAIN_SERVICE = '';
  static const String MAIN_TITLE = 'Demo de Agenda';
  static const String SUB_TITLE = 'Ete es el subtitulo';
}