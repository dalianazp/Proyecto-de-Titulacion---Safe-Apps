import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pag2_pagina_principal.dart';

class Pag1Introduccion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

   void goToPaginaPrincipal(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => PaginaPrincipal(imei_identifier: '58C9E829-EA16-44B5-820F-879B56BE0E97')));

    PageDecoration getPageDecoration() => PageDecoration(
      titleTextStyle: TextStyle (
          fontSize: 22.0,
          fontFamily: "black",
          height: 1.5
      ),
      /*titlePadding: EdgeInsets.only(
        top: 50.0,
        bottom: 50.0
      ),*/
      bodyTextStyle: TextStyle (
        fontSize: 18.0,
        fontFamily: "light",
        height: 1.5,
      ),
      bodyPadding: EdgeInsets.only(
        left: 30.0,
        right: 30.0,
      ),
      imagePadding: EdgeInsets.zero,
      //imageAlignment: Alignment.center,
      //  imageAlignment: Alignment.bottomCenter,
      //bodyAlignment: Alignment.topRight
    );


    final v = Container(
        margin: EdgeInsets.zero,
        //SafeArea(
        /*top: false,
        bottom: false,
        left: false,
        right: false,*/
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              image: SvgPicture.asset("assets/img/bienvenida1.svg", width: 150,),
              title: "Doble factor de autenticación",
              body: "Mejora la seguridad de tus aplicaciones mediante la verificación de dos pasos usando contraseñas de un solo uso (OTP)",
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              image: SvgPicture.asset("assets/img/bienvenida2.svg", width: 60,),
              title: "Registro de aplicaciones",
              body: "Para registrar una aplicación escanea el código QR que aparecerá en tu aplicación al momento de activar la verificación de dos pasos ",
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              image: SvgPicture.asset("assets/img/bienvenida3.svg", width: 100,),
              title: "Contraseñas de un solo uso (OTP)",
              body: "Una de las formas de utilizar la verificación de dos pasos es mediante el uso de contraseñas de uso único",
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              image: SvgPicture.asset("assets/img/bienvenida4.svg", width: 250,),
              title: "Métodos de entrega de OTP",
              body: "Dependiendo de la aplicación, la contraseña de uso único (OTP) es entregada al usuario mediante diferentes formas:  SMS, correo electrónico,  códigos QR, entre otros",
              decoration: getPageDecoration(),
            )
          ],
          done: Text('Comenzar', style: TextStyle(fontWeight: FontWeight.w400),),
          onDone: () => goToPaginaPrincipal(context),
          showNextButton: true,
          next: Text("Siguiente"),
          showSkipButton: true,
          skip: Text("Omitir"),
          onSkip: () => goToPaginaPrincipal(context),
        ));
    return v;
  }

}