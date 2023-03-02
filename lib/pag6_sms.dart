import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'pag1_introducccion.dart';
import 'pag3_preguntas_frecuentes.dart';
import 'pag2_pagina_principal.dart';
import 'pag8_confirmacion_error.dart';
import 'pag7_pantalla_confirmacion_envio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SMS extends StatefulWidget {
  const SMS({super.key});

  @override
  State<SMS> createState() => _SMSState();
}

class _SMSState extends State<SMS> {
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

  void _finish() async {
    setState(() {
      _isLoading = false;
      _post_otp_of_authenticationserver();
    });
    dynamic pop = await Navigator.pushNamed(context, '/confirmaciondeenvio');
  }

  Future<http.Response> _post_otp_of_authenticationserver() {
    return http.post(
      Uri.parse('http://172.31.107.49:5031/otp-movil'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'otp-val': "$_code",
      }),
    );
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

    void confirmacion(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ConfirmacionEnvio())
    );

    void error(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ConfirmacionError())
    );

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
        child: Wrap (
          children: [
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
                      child: SvgPicture.asset('assets/img/sms.svg'),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 30,
                      child:  RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(fontSize: 18, fontFamily: "regular",color: Colors.black),
                          children: <TextSpan> [
                            TextSpan(text: "Escriba el código OTP que se muestra en "),
                            TextSpan(text: "el prototipo web", style: TextStyle(fontSize: 18, fontFamily: "bold" /*, color: Color(0xFF1B8DE4)*/)),
                          ],
                        ),
                      ),
                    ),
                    Container(margin: EdgeInsets.only(top: 50), width: MediaQuery.of(context).size.width - 50, //ver
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
                            if (!_onEditing) FocusScope.of(context).unfocus(); else FocusScope.of(context).nextFocus();
                          });
                        },
                        onEditing: (bool value) {
                          setState(() {
                            _onEditing = value;
                            _buttondisable = true;
                            _onEditing = true;
                          });
                          if (!_onEditing) FocusScope.of(context).unfocus();
                        },
                        clearAll: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                              child: Text('Borrar código OTP', style: TextStyle(fontSize: 13.0, decoration: TextDecoration.underline,color: Colors.black))
                          ),),
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
                  ],),),

          ],
        )

      ),
    );
  }
}

