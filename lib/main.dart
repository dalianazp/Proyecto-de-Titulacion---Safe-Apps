import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'pag1_introducccion.dart';
import 'pag2_pagina_principal.dart';
import 'pag3_preguntas_frecuentes.dart';
import 'pag5_correo_electronico.dart';
import 'pag6_sms.dart';
import 'pag7_pantalla_confirmacion_envio.dart';
import 'pag8_confirmacion_error.dart';
import 'qr_escaneo_otp.dart';
import 'qr_registro_de_apps.dart';
import 'imei_info.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //OBTENER EL NUMERO IMEI DEL TELEFONO DEL USUARIO USANDO EL LOCAL STORAGE DE FLUTTER (SHARED-PREFERENCE)
  //SharedPreferences prefs2 = await SharedPreferences.getInstance();
  //String? myValue = prefs2.getString('imei_number');
 // print('main: ' + myValue!);
  runApp(MyApp());
}

class MyApp extends StatelessWidget  {
  //String imei_identificador;
  //MyApp(this.imei_identificador);
  //const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final doc = db.doc("/aplicaciones_registradas/YCPCDnFdWAeG8y8Ssl5A");

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),

      initialRoute: '/paginaPrincipal',
      routes: {
        '/paginaPrincipal' : (context) => PaginaPrincipal(imei_identifier: '58C9E829-EA16-44B5-820F-879B56BE0E97',),
        '/escaneoOTP' : (context) => QREscaneoOTP(imei_identifier: '58C9E829-EA16-44B5-820F-879B56BE0E97',),
        '/registroApps' : (context) => QRRegistroApp(imei_identifier: '58C9E829-EA16-44B5-820F-879B56BE0E97',),
        '/introduccion' : (context) => Pag1Introduccion(),
        '/preguntasFrecuentes' : (context) => PreguntasFrecuentes(),
        '/sms' : (context) => SMS(),
        '/correoElectronico' : (context) => CorreoElectronico(),
        '/confirmaciondeenvio' : (context) => ConfirmacionEnvio(),
        '/confirmaciondeerror' : (context) => ConfirmacionError(),
        '/imei_info' : (context) => IMEI_Info(),
      },
    );
  }
}
