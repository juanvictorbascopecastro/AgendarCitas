class Cita{
  String _id;
  String _empresa;
  String _detalles;
  DateTime _fecha;
  DateTime _fecha_registrada;

  Cita(this._id, this._empresa, this._detalles, this._fecha,
      this._fecha_registrada);

  DateTime get fecha_registrada => _fecha_registrada;

  set fecha_registrada(DateTime value) {
    _fecha_registrada = value;
  }

  DateTime get fecha => _fecha;

  set fecha(DateTime value) {
    _fecha = value;
  }

  String get detalles => _detalles;

  set detalles(String value) {
    _detalles = value;
  }

  String get empresa => _empresa;

  set empresa(String value) {
    _empresa = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}