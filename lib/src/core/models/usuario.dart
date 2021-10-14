class Usuario{
  String _id;
  String _nombre;
  String _email;

  Usuario(this._id, this._nombre, this._email);

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}