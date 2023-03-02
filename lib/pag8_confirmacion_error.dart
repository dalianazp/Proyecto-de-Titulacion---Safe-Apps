import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pag2_pagina_principal.dart';

class ConfirmacionError extends StatelessWidget {
  String texto = "Lo sentimos, el código no pudo ser enviado. Por favor intente nuevamente.";
  String imagen = "assets/img/error.svg";
  String texto_inicial = "ERROR";

  @override
  Widget build(BuildContext context) {

    void goToBack(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => PaginaPrincipal(imei_identifier: '58C9E829-EA16-44B5-820F-879B56BE0E97'))
    );

    return MaterialApp(
      home: Scaffold(
        body: Center (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 130,
                height: 130,
                padding: EdgeInsets.all(20),
                child: SvgPicture.asset(imagen),
              ),
              Container(margin: EdgeInsets.only(bottom: 30.0),
                  child: Text (texto_inicial, style: TextStyle(fontSize: 30, fontFamily: 'bold'),)
              ),
              Container(margin: EdgeInsets.symmetric(horizontal: 40),
                  child: Text (texto, style: TextStyle(fontSize: 18, fontFamily: 'regular'),textAlign: TextAlign.center,)
              ),
              Container(
                margin: EdgeInsets.all(50),
                child: MaterialButton(
                  color: Color(0xD1E30613),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  minWidth: 500,
                  height: 50,
                  onPressed: () => goToBack(context),
                  child: Text("Entendido", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "regular" ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}