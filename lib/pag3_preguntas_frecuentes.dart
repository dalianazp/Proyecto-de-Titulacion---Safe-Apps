import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'accordion_item_list.dart';
import 'pag1_introducccion.dart';
import 'pag2_pagina_principal.dart';

class PreguntasFrecuentes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void bienvenida(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Pag1Introduccion())
    );

    void preguntasFrecuentes(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => PreguntasFrecuentes())
    );

    void goToBack(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => PaginaPrincipal(imei_identifier: '58C9E829-EA16-44B5-820F-879B56BE0E97'))
    );


    final name_icono = Row(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: 30.0,
              bottom: 30.0,
              left: 30.0,
              right: 10.0
          ),
          child: Icon(
            CupertinoIcons.question_circle_fill,
            color: Colors.blue,
            size: 30.0,
          ),
        ),
        Row(
          children: [
            Text("Preguntas frecuentes", style: TextStyle(
              fontSize: 20.0,
              fontFamily: "bold",
            ),)
          ],
        )
      ],
    );

    final listaDePreguntas = Container(
      //height: 97.0,
      // width: 140,
      margin: EdgeInsets.only(
          top: 80.0,
          bottom: 80.0
      ),
      child: ListView(
        children: <Widget> [
          AccordionItemList()
        ],
      ),
    );

    //ICONOS DEL APP BAR
    return MaterialApp(
      //title: 'Splash',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
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

          //STACK DEL BODY
          body: Stack (
            children: <Widget>[
              listaDePreguntas,
              name_icono,
            ],
          )),
    );

  }
}