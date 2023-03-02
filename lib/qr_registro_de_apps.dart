import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mz_rsa_plugin/mz_rsa_plugin.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'pag1_introducccion.dart';
import 'pag2_pagina_principal.dart';
import 'pag3_preguntas_frecuentes.dart';


const String PUBLICK_KEY =
    "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArdklK4kIsOMuxTZ8jG1PRPfXqSDmaCIQ+xEpIRSssQ6jiuvhYZTMUbV22osgtivuyKdnHm+cvzGuZCSB8QFyCcM7l09HZVs0blLkrBAU5CVSv+6BzPQTVJytoi/VO4mlf6me1Y9bXWrrPw1YtC1mnB2Ix9cuaxOLpucglfGbUaGEigsUZMTD2vuEODN5cJi39ap+G9ILitbrnt+zsW9354pokVnHw4Oq837Fd7ZtP0nAA5F6nE3FNDGQqLy2WYRoKC9clDecD8T933azUD98b5FSUGzIhwiuqHHeylfVbevbBW91Tvg9s7vUMr0Y2YDpEmPAf0q4PlDt8QsjctT9kQIDAQAB";
const String PRIVART_KEY =
    "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCt2SUriQiw4y7FNnyMbU9E99epIOZoIhD7ESkhFKyxDqOK6+FhlMxRtXbaiyC2K+7Ip2ceb5y/Ma5kJIHxAXIJwzuXT0dlWzRuUuSsEBTkJVK/7oHM9BNUnK2iL9U7iaV/qZ7Vj1tdaus/DVi0LWacHYjH1y5rE4um5yCV8ZtRoYSKCxRkxMPa+4Q4M3lwmLf1qn4b0guK1uue37Oxb3fnimiRWcfDg6rzfsV3tm0/ScADkXqcTcU0MZCovLZZhGgoL1yUN5wPxP3fdrNQP3xvkVJQbMiHCK6ocd7KV9Vt69sFb3VO+D2zu9QyvRjZgOkSY8B/Srg+UO3xCyNy1P2RAgMBAAECggEAInVN9skcneMJ3DEmkrb/5U2yw2UwBifqcbk/C72LVTTvmZOTgsH5laCARGUbQMCIfeEggVniGcuBI3xQ/TIqJmE6KI2gOyjOxadMiAZP/cCgHEbsF3Gxey3rBKCyhTCNSzaVswLNO0D8C+1bTatKEVuRRvsRykt/fL+HJ/FRteYYO9LuLv2WESJGE6zsi03P6snNiRracvYqz+Rnrvf1Xuyf58wC1C6JSjZ9D6tootPDBTEYaIIbpEnV+qP/3k5OFmA9k4WbkZI6qYzqSK10bTQbjMySbatovnCD/oqIUOHLwZpL051E9lz1ZUnDbrxKwT0BIU7y4DYaHSzrKqRsIQKBgQDTQ9DpiuI+vEj0etgyJgPBtMa7ClTY+iSd0ccgSE9623hi1CHtgWaYp9C4Su1GBRSF0xlQoVTuuKsVhI89far2Z0hR9ULr1J1zugMcNESaBBC17rPoRvXPJT16U920Ntwr00LviZ/DEyvmpVDagYy+mSK0Wq+kH7p5aR5zAHXWrQKBgQDSqQ6TBr5bDMvhpRi94unghiWyYL6srSRV9XjqDpiNU+yFwCLzSG610DyXFa3pV138P+ryunqg1LtKsOOtZJONzbS1paINnwkvfwzMpI7TjCq1+8rxeEhZ3AVmumDtPQK+YfGbxCQ+LAOJZOu8lGv1O7tsbXFp0vh5RmWHWHvy9QKBgCMGPi9JsCJ4cpvdddQyizLk9oFxwAlMxx9G9P08H7kdg4LW6l0Gs+yg/bBf86BFHVbmXW8JoBwHj418sYafO+Wnz8yOna6dTBEwiG13mNvzypVu4nKiuQPDh8Ks/rdu1OeLGbC+nzbnCcMuKw5epee/WYqO8kmCXRbdv4ePTvntAoGBAJYQ9F7saOI3pW2izJNIeE8HgQcnP+2GkeHiMjaaGzZiWJWXH86rBKLkKqV+PhuBr2QorFgpW34CzUER7b7xbOORbHASA/UsG8EIArgtacltimeFbTbC9td8kyRxFOcrlS7GWvUZrq/TbtmLWRtHp/hUitlcxXQbZAIQkfbuo62ZAoGBAKBURvLGM0ethkvUHFyGae2YGG/s+u+EYd2zNba7A6qnfzrlMHVPiPO6lx31+HwhuJ0tBZWMJKhEZ5PWByZzreVKVH5fE5LoQLo+B3VCTyTc1fJ9RKLAPrPqHuvzPHHP/n84XHGeit3e4ytd3Mm/6CNbrg7xux2M4RDQmN//1UOY";

final db = FirebaseFirestore.instance;


void main() {
  runApp(MaterialApp(
    home: FutureBuilder<String>(
      future: getIMEINumber(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return QRRegistroApp(imei_identifier: snapshot.data!);
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    ),
  ));
}
class QRRegistroApp extends StatefulWidget {
  final String imei_identifier;
  QRRegistroApp({required this.imei_identifier});


  @override
  State<StatefulWidget> createState() => _QRRegistroAppState();
}

class _QRRegistroAppState extends State<QRRegistroApp> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

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
      body: Stack(
        children: <Widget>[
          _buildQrView(context),
          Container(
            margin: EdgeInsets.only(top: 500, right: 60, left: 60),
            child: Text("Coloque el código QR dentro de las líneas azules", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "light"), textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }

  _showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Icon(
                      (CupertinoIcons.check_mark_circled),
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  Center(
                    child: const Text(
                      'Mensaje de confirmación',
                      style: TextStyle(
                          fontFamily: "bold",
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(5),
              ),
            ],
          ),
          content: const Text('¿Está seguro de registrar esta aplicación?', style: TextStyle(fontFamily: "regular", fontSize: 16)),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              /// This parameter indicates this action is the default,
              /// and turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: () async{
                Navigator.push(context, MaterialPageRoute(builder: (context) => PaginaPrincipal(imei_identifier: '58C9E829-EA16-44B5-820F-879B56BE0E97')));
              },
              child: const Text('No', style: TextStyle(fontFamily: "regular", color: Colors.black),),
            ),
            CupertinoDialogAction(
              /// This parameter indicates the action would perform
              /// a destructive action such as deletion, and turns
              /// the action's text color to red.
              isDestructiveAction: true,
              onPressed: () async {

                // Número IMEI del dispositivo del usuario
                String userID = '/${widget.imei_identifier}/';

                //CONSUMO DE LA API PARA OBTENER LOS DATOS DE REGISTRO DE LA APLICACION
                final res = await http.get(
                    Uri.parse("http://192.168.100.7:5003/otp-config"));
                final resData = json.decode(res.body);

                //ENCRIPTAR MEDIANTE RSA LOS DATOS OBTENIDOS
                var appNombre = await MzRsaPlugin.encryptStringByPublicKey(resData['app-name'], PUBLICK_KEY);
                var appLogo = await MzRsaPlugin.encryptStringByPublicKey(resData['app-logo'], PUBLICK_KEY);
                var metodoEntrega = await MzRsaPlugin.encryptStringByPublicKey(resData['entrega'], PUBLICK_KEY);
                var userCorreo = await MzRsaPlugin.encryptStringByPublicKey(resData['user-email'], PUBLICK_KEY);

                //ENVIO DE DATOS ENCRIPTADOS A FIREBASE
                DocumentReference<Map<String, dynamic>> datosdeusuarios_doc = FirebaseFirestore.instance
                    .collection('/aplicaciones_registradas/').doc(userID);
                CollectionReference<Map<String, dynamic>> datosdeusuario_subcoleccion = datosdeusuarios_doc
                    .collection(userID);
                DocumentReference<Map<String, dynamic>> documentReference2 = await datosdeusuario_subcoleccion
                    .add({'app-logo':appLogo, 'app-name':appNombre,'entrega':metodoEntrega, 'user-email': userCorreo});

                ScaffoldMessenger.of(context).showSnackBar (
                    SnackBar(
                      content: Text("Aplicación registrada exitosamente!"),
                    )
                );

                Navigator.push(context, MaterialPageRoute(builder: (context) => PaginaPrincipal(imei_identifier: '58C9E829-EA16-44B5-820F-879B56BE0E97')));
              },
              child: const Text('Registrar', style: TextStyle(fontFamily: "bold", color: Colors.blue),),
            ),
          ],
        )
    );
  }


  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Color(0xFF1B8DE4),
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 20,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    bool gotValidQR = true;

    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      if(gotValidQR) {
        gotValidQR = false;
        controller.pauseCamera();
        _showAlertDialog(context);
        //print({'$result!.code'});
        //print(gotValidQR);
      }else {
        //Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmacionError()));
        controller.resumeCamera();
        //dynamic pop = await Navigator.pushNamed(context, '/paginaPrincipal');
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

Future<String> getIMEINumber() async {
  String imeiNo = await DeviceInformation.deviceIMEINumber;
  return imeiNo;
}

