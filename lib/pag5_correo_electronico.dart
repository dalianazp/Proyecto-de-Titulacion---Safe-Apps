import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'pag1_introducccion.dart';
import 'pag3_preguntas_frecuentes.dart';
import 'pag2_pagina_principal.dart';


class CorreoElectronico extends StatefulWidget {
  const CorreoElectronico({super.key});

  @override
  State<CorreoElectronico> createState() => _CorreoElectronicoState();
}

class _CorreoElectronicoState extends State<CorreoElectronico> {
  bool _onEditing = true;
  bool _buttondisable = true;
  String? _code;
  bool _borrarOTP = false;
  bool _isLoading = false;
  bool _isVerified = false;

  verify () {
    setState(() {
      _isLoading = true;
      Timer(Duration(seconds: 3), () {
        _finish();
      });
    });
  }

  void _finish() {
    setState(() {
      _isLoading = false;
      //Implementar lógica de conexión al servidor para saber si se mandó o no el otp
      ScaffoldMessenger.of(context).showSnackBar (
          SnackBar(
            content: Text("OTP enviado exitosamente!"),
          )
      );
      print('El otp es: $_code');
    });
  }

  @override
  build(BuildContext context) {

    void bienvenida(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Pag1Introduccion())
    );

    void preguntasFrecuentes(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => PreguntasFrecuentes())
    );

    void goToBack(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => PaginaPrincipal(imei_identifier: '58C9E829-EA16-44B5-820F-879B56BE0E97'))
    );

    Size displaySize(BuildContext context) {
      print('Size = ' + MediaQuery.of(context).size.toString());
      return MediaQuery.of(context).size;
    }

    double displayHeight(BuildContext context) {
      print('Height = ' + displaySize(context).height.toString());
      return displaySize(context).height;
    }

    double displayWidth(BuildContext context) {
      print('Width = ' + displaySize(context).width.toString());
      return displaySize(context).width;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        shadowColor: Color(0xFF666666),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => goToBack(context),
          child: Icon(CupertinoIcons.arrow_left, color: Color(0xFF404040)),
        ),
        actions: <Widget> [
          PopupMenuButton<int>(
            child: Container(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                CupertinoIcons.ellipsis_vertical,
                color: Color(0xFF404040),
              ),
            ),
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                value: 1,
                // row with 2 children
                child: Row(
                  children: [
                    Icon(CupertinoIcons.text_bubble, color: Colors.blue), //Color(0xFFBAC0CA),),
                    SizedBox(
                      width: 10,
                    ),
                    Text("¿Cómo funciona?", style: TextStyle(
                        fontFamily: "regular",
                        fontSize: 18.0
                    ),)
                  ],
                ),

              ),
              // PopupMenuItem 2
              PopupMenuItem(
                value: 2,
                // row with two children
                child: Row(
                  children: [
                    Icon(CupertinoIcons.question_circle, color: Colors.blue), //Color(0xFFBAC0CA),),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Preguntas frecuentes", style: TextStyle(
                        fontFamily: "regular",
                        fontSize: 18.0
                    ),)
                  ],
                ),
              ),
            ],
            offset: Offset(0, 40),
            color: Colors.white,
            //elevation: 10,
            // on selected we show the dialog box
            onSelected: (value) {
              // if value 1 show dialog
              if (value == 1) {
                bienvenida(context);
                // if value 2 show dialog
              } else if (value == 2) {
                preguntasFrecuentes(context);
              }
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) {currentFocus.unfocus();}
        },
        child: Wrap (children: [
          Container (
          height: MediaQuery.of(context).size.height, //ver
          width: MediaQuery.of(context).size.width, //ver
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 130,
                height: 130,
                padding: EdgeInsets.all(20),
                child: Image.asset('assets/img/correo.png'),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                //margin: EdgeInsets.symmetric(horizontal: 20),
                //padding: EdgeInsets.symmetric(horizontal: 50),
                child:  RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 18, fontFamily: "regular",color: Colors.black),
                    children: <TextSpan> [
                      TextSpan(text: "Escriba el código OTP que recibió mediante "),
                      TextSpan(text: "correo electrónico", style: TextStyle(fontSize: 18, fontFamily: "bold" /*, color: Color(0xFF1B8DE4)*/)),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width - 50, //ver
                child: VerificationCode(
                  //pasteStream: Stream.fromFuture(future),
                  itemSize: 40,
                  length: 6,
                  fullBorder: true,
                  digitsOnly: true,
                  textStyle: TextStyle(fontFamily: "regular", fontSize: 18),
                  keyboardType: TextInputType.number,
                  underlineColor: Colors.blue,
                  underlineUnfocusedColor: Colors.grey,
                  cursorColor: Colors.blue,
                  margin: const EdgeInsets.all(5),
                  onCompleted: (String value) {
                    setState(() {
                      _code = value;
                      _buttondisable = false;
                      _onEditing = false;
                      FocusScope.of(context).nextFocus();

                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                      _buttondisable = true;
                      _onEditing = true;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();//FocusScope.of(context).unfocus();
                  },
                  clearAll: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                        child: Text('Borrar código OTP', style: TextStyle(fontSize: 13.0, decoration: TextDecoration.underline,color: Colors.black))
                    ),),
                  /*clearAll: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _onEditing
                        ? null
                        : Text('Borrar código OTP',
                      style: TextStyle(
                          fontSize: 15.0,
                          decoration: TextDecoration.underline,
                          color: Colors.blue[700]),
                    ),
                  ),*/
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 100, top: 120),
                width: MediaQuery.of(context).size.width - 50, //ver
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton (
                  color: Color(0xFF1B8DE4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  //child: Text("Enviar", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "bold" ),),
                  onPressed: _buttondisable ? null :  () {
                    setState(() {
                      verify();
                    });},
                  disabledColor: Color(0xffBAC0CA),
                  //color: Color(0xFF1B8DE4),
                  minWidth: 500,
                  height: 50,
                  child: _isLoading ? Container(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xFFCEE4F6),
                      strokeWidth: 3,
                      color: Colors.white,
                    ),

                  ) : Text("Enviar", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "bold" ),),
                ),
              )
            ],
          ),
        ),]
      ),
    ),);
  }
}
