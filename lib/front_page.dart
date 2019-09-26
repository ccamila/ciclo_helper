import 'package:ciclo_helper/home_page.dart';
import 'package:flutter/material.dart';
import "login_page.dart";
import "authentication.dart";

class FrontPage extends StatefulWidget{
  FrontPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _FrontPageState();
}

enum AuthStatus{
  notSignedIn,
  signedIn
}

class _FrontPageState extends State<FrontPage>{
  AuthStatus authStatus = AuthStatus.notSignedIn;
  
  @override
  void initState(){
    super.initState();
    widget.auth.currentUser().then((String userId){
      setState(() {
         authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn(){
    setState(() {
     authStatus = AuthStatus.signedIn; 
    });
  }

  void _signedOut(){
    setState(() {
     authStatus = AuthStatus.notSignedIn; 
    });    
  }


  @override
  Widget build(BuildContext context) {
    switch(authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return new HomePage(
            auth: widget.auth,
            onSignedOut: _signedOut,
        );
    }
  }
}