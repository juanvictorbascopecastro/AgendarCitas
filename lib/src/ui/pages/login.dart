import 'package:agenda/src/core/services/user_management.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  UserManagement userManagement;
  BuildContext context;
  LoginPage(this.userManagement, this.context, {Key key}) : super(key: key);
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  bool _loading = false;
  FocusNode myFocusNode = new FocusNode();
  String userName = '';
  String userPassword = '';
  var user;
  final _formKey = GlobalKey<FormState>();

  String _errorMessage = '';

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
              child: Image.asset("assets/images/agenda.png",
                //color: Colors.white
                width: 80,
                height: 80,
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
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(labelText: "Email:"),
                              onSaved: (value){
                                userName = value;
                              },
                              validator: (value){
                                if(value.isEmpty){
                                  return '¡Este campo es necesario!';
                                }
                              },
                            ),
                            SizedBox(height: 25),
                            TextFormField(
                              decoration: InputDecoration(labelText: "Contraseñá:"),
                              obscureText: true,
                              onSaved: (value){
                                userPassword = value;
                              },
                              validator: (value){
                                if(value.isEmpty){
                                  return '¡Este campo es necesario!';
                                }
                              },
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
                            SizedBox(height: 25),
                            RaisedButton(
                                color: Theme.of(context).primaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                textColor: Colors.white,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Iniciar sesión'),
                                      if(_loading)
                                        Container(
                                          height: 20,
                                          width: 20,
                                          margin: const EdgeInsets.only(left: 20),
                                          child: CircularProgressIndicator(),
                                        )
                                    ]),
                                onPressed: (){
                                  _login(context);
                                }
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            /*Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('¿No esta registrado?'),
                                FlatButton(
                                  textColor: Theme.of(context).primaryColor,
                                  onPressed: (){
                                    _showRegister(context);
                                  },
                                  child: Text('Registrarse'),
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
  void _login(BuildContext context){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      if(!_loading){
        setState(() {
          _loading = true;
        });
        FirebaseAuth.instance.signInWithEmailAndPassword(email: userName, password: userPassword)
          .then((user) {
            print(user);
              Navigator.of(context).pushReplacementNamed("/home", arguments: user);
          }).catchError((e){
              if(e.message == 'auth/wrong-password'){
                  _errorMessage = 'Contraseña incorrecta';
              }else if(e.code == 'user-not-found'){
                  _errorMessage = 'Usuario no encontrado';
              }else{
                  _errorMessage = e.message;
              }
              _loading = false;
          });
      }
    }
  }
  /*void _showRegister(BuildContext context) {
    Navigator.of(context).pushNamed('/register');
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget.userManagement.getUser();
  }
}