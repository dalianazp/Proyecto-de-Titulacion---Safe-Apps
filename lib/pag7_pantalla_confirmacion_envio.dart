import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pag2_pagina_principal.dart';


class ConfirmacionEnvio extends StatelessWidget {
  String texto = "Código enviado exitosamente !";
  String imagen = "assets/img/success.svg";
  String texto_inicial = "ENVIADO";

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
              //width: 130,
              //height: 130,
              padding: EdgeInsets.all(20),
              child: SvgPicture.asset(imagen),
            ),
              Container(margin: EdgeInsets.only(bottom: 30.0),
                  child: Text (texto_inicial, style: TextStyle(fontSize: 30, fontFamily: 'bold'),)
              ),
              Container(
                child: Text (texto, style: TextStyle(fontSize: 18, fontFamily: 'regular'),)
              ),
              Container(
                margin: EdgeInsets.all(50),
                child: MaterialButton(
                  color: Color(0xD13AAA35),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  minWidth: 500,
                  height: 50,
                  onPressed: () => goToBack(context),
                  child: Text("Continuar", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "regular" ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}