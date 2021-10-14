import 'package:agenda/src/core/services/user_management.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage>{
  bool _loading = false;
  FocusNode myFocusNode = new FocusNode();
  String _userName = '';
  String _userEmail = '';
  String _userPassword = '';

  GlobalKey<FormState> _formKey= GlobalKey<FormState>();

  String _errorMessage = '';
  bool _show_password = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 60),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange,
                      Colors.deepOrange
                    ],
                  ),
                ),
              ),
              SizedBox(
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  iconTheme: IconThemeData(color: Colors.white),
                ),
              ),
              Transform.translate(offset: Offset(0, -40),
                child: Center(
                  child: SingleChildScrollView(
                    child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        margin: const EdgeInsets.only(left: 20, right:  20, top: 60, bottom: 20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
                          child: Column(
                            mainAxisSize:  MainAxisSize.min,
                            children: [
                              TextFormField(
                                //cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(labelText: "Nombre Completo:"),
                                onSaved: (value){
                                  _userName = value;
                                },
                                validator: (value){
                                  if(value.isEmpty){
                                    return '¡Este campo es necesario!';
                                  }
                                },
                              ),
                              SizedBox(height: 25),
                              TextFormField(
                                //cursorColor: Theme.of(context).primaryColor,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(labelText: "Email:"),
                                onSaved: (value){
                                  _userEmail = value;
                                },
                                validator: (value){
                                  if(value.isEmpty){
                                    return '¡Este campo es necesario!';
                                  }
                                },
                              ),
                              SizedBox(height: 25),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Contraseñá:",
                                  suffixIcon: IconButton(
                                    icon: Icon(_show_password? Icons.visibility:Icons.visibility_off),
                                    onPressed: (){
                                      setState(() {
                                        _show_password = !_show_password;
                                      });
                                    },
                                  ),

                                ),
                                obscureText: !_show_password,
                                onSaved: (value){
                                  _userPassword = value;
                                },
                                validator: (value){
                                  if(value.isEmpty){
                                    return '¡Este campo es necesario!';
                                  }else if(value.length <6){
                                    return '¡Contraseña debe ser mayor o igual a 6 digitos!';
                                  }
                                },
                              ),
                              SizedBox(height: 25),
                              RaisedButton(
                                  color: Theme.of(context).primaryColor,
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  textColor: Colors.white,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Registrarme'),
                                        if(_loading)
                                          Container(
                                            height: 20,
                                            width: 20,
                                            margin: const EdgeInsets.only(left: 20),
                                            child: CircularProgressIndicator(),
                                          )
                                      ]),
                                  onPressed: (){
                                    _register(context);
                                  }
                              ),
                              if(_errorMessage.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    _errorMessage,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              SizedBox(
                                height: 20,
                              ),
                              /*Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('¿Ya tiene una cuenta?'),
                                  FlatButton(
                                    textColor: Theme.of(context).primaryColor,
                                    onPressed: (){
                                      _showRegister(context);
                                    },
                                    child: Text('Iniciar sesión'),
                                  )
                                ],
                              )*/
                            ],
                          ),
                        )
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  void _register(BuildContext context){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      if(!_loading){
        setState(() {
          _loading = true;
        });

        FirebaseAuth.instance.createUserWithEmailAndPassword(email: _userEmail, password: _userPassword)
        .then((signedInUser){
          print(signedInUser);
          //UserManagement().storeNewUser(signedInUser.user, context);
          signedInUser.user.updateProfile(displayName: _userName)
            .then((value) {
                UserManagement().storeNewUser(signedInUser.user.email, signedInUser.user.uid, _userName, context);
            });
        }).catchError((e){
          if (e.code == 'weak-password') {
            _errorMessage = 'La contraseña proporcionada es demasiado débil.';
          } else if (e.code == 'email-already-in-use') {
            _errorMessage = 'La cuenta ya existe para ese correo electrónico.';
          }else if(e.code == 'invalid-email'){
            _errorMessage = 'Correo electronico inválido.';
          }else{
            _errorMessage = e.message;
          }
          _loading = false;
        });
      }
    }
  }

}

/*void _showRegister(BuildContext context) {
  Navigator.of(context).pushNamed('/login');
}*/

