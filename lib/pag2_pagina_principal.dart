import 'package:device_information/device_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mz_rsa_plugin/mz_rsa_plugin.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
const String PUBLICK_KEY =
    "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArdklK4kIsOMuxTZ8jG1PRPfXqSDmaCIQ+xEpIRSssQ6jiuvhYZTMUbV22osgtivuyKdnHm+cvzGuZCSB8QFyCcM7l09HZVs0blLkrBAU5CVSv+6BzPQTVJytoi/VO4mlf6me1Y9bXWrrPw1YtC1mnB2Ix9cuaxOLpucglfGbUaGEigsUZMTD2vuEODN5cJi39ap+G9ILitbrnt+zsW9354pokVnHw4Oq837Fd7ZtP0nAA5F6nE3FNDGQqLy2WYRoKC9clDecD8T933azUD98b5FSUGzIhwiuqHHeylfVbevbBW91Tvg9s7vUMr0Y2YDpEmPAf0q4PlDt8QsjctT9kQIDAQAB";
const String PRIVART_KEY =
    "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCt2SUriQiw4y7FNnyMbU9E99epIOZoIhD7ESkhFKyxDqOK6+FhlMxRtXbaiyC2K+7Ip2ceb5y/Ma5kJIHxAXIJwzuXT0dlWzRuUuSsEBTkJVK/7oHM9BNUnK2iL9U7iaV/qZ7Vj1tdaus/DVi0LWacHYjH1y5rE4um5yCV8ZtRoYSKCxRkxMPa+4Q4M3lwmLf1qn4b0guK1uue37Oxb3fnimiRWcfDg6rzfsV3tm0/ScADkXqcTcU0MZCovLZZhGgoL1yUN5wPxP3fdrNQP3xvkVJQbMiHCK6ocd7KV9Vt69sFb3VO+D2zu9QyvRjZgOkSY8B/Srg+UO3xCyNy1P2RAgMBAAECggEAInVN9skcneMJ3DEmkrb/5U2yw2UwBifqcbk/C72LVTTvmZOTgsH5laCARGUbQMCIfeEggVniGcuBI3xQ/TIqJmE6KI2gOyjOxadMiAZP/cCgHEbsF3Gxey3rBKCyhTCNSzaVswLNO0D8C+1bTatKEVuRRvsRykt/fL+HJ/FRteYYO9LuLv2WESJGE6zsi03P6snNiRracvYqz+Rnrvf1Xuyf58wC1C6JSjZ9D6tootPDBTEYaIIbpEnV+qP/3k5OFmA9k4WbkZI6qYzqSK10bTQbjMySbatovnCD/oqIUOHLwZpL051E9lz1ZUnDbrxKwT0BIU7y4DYaHSzrKqRsIQKBgQDTQ9DpiuI+vEj0etgyJgPBtMa7ClTY+iSd0ccgSE9623hi1CHtgWaYp9C4Su1GBRSF0xlQoVTuuKsVhI89far2Z0hR9ULr1J1zugMcNESaBBC17rPoRvXPJT16U920Ntwr00LviZ/DEyvmpVDagYy+mSK0Wq+kH7p5aR5zAHXWrQKBgQDSqQ6TBr5bDMvhpRi94unghiWyYL6srSRV9XjqDpiNU+yFwCLzSG610DyXFa3pV138P+ryunqg1LtKsOOtZJONzbS1paINnwkvfwzMpI7TjCq1+8rxeEhZ3AVmumDtPQK+YfGbxCQ+LAOJZOu8lGv1O7tsbXFp0vh5RmWHWHvy9QKBgCMGPi9JsCJ4cpvdddQyizLk9oFxwAlMxx9G9P08H7kdg4LW6l0Gs+yg/bBf86BFHVbmXW8JoBwHj418sYafO+Wnz8yOna6dTBEwiG13mNvzypVu4nKiuQPDh8Ks/rdu1OeLGbC+nzbnCcMuKw5epee/WYqO8kmCXRbdv4ePTvntAoGBAJYQ9F7saOI3pW2izJNIeE8HgQcnP+2GkeHiMjaaGzZiWJWXH86rBKLkKqV+PhuBr2QorFgpW34CzUER7b7xbOORbHASA/UsG8EIArgtacltimeFbTbC9td8kyRxFOcrlS7GWvUZrq/TbtmLWRtHp/hUitlcxXQbZAIQkfbuo62ZAoGBAKBURvLGM0ethkvUHFyGae2YGG/s+u+EYd2zNba7A6qnfzrlMHVPiPO6lx31+HwhuJ0tBZWMJKhEZ5PWByZzreVKVH5fE5LoQLo+B3VCTyTc1fJ9RKLAPrPqHuvzPHHP/n84XHGeit3e4ytd3Mm/6CNbrg7xux2M4RDQmN//1UOY";


void main() {
  runApp(MaterialApp(
    home: FutureBuilder<String>(
      future: getIMEINumber(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return PaginaPrincipal(imei_identifier: snapshot.data!);
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    ),
  ));
}

class PaginaPrincipal extends StatefulWidget {
  final String imei_identifier;
  PaginaPrincipal({required this.imei_identifier});

  @override
  State<StatefulWidget> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal>{

  Future<String> desencriptar (String dato) async {
    var str2 = await MzRsaPlugin.decryptStringByPrivateKey(dato, PRIVART_KEY);
    return str2;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    String userID = '/${widget.imei_identifier}/';

    void sms(context) => Navigator.of(context).pushReplacementNamed('/sms');
    void escaneoqr(context) => Navigator.of(context).pushReplacementNamed('/escaneoOTP');
    void bienvenida(context) => Navigator.of(context).pushReplacementNamed('/introduccion');
    void preguntasFrecuentes(context) => Navigator.of(context).pushReplacementNamed('/preguntasFrecuentes');
    void QRRegistroApplicacion(context) => Navigator.of(context).pushReplacementNamed('/registroApps');

    //Titulo de la pagina
    final name = Container(
      //padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(30.0),
      child: const Text ("Aplicaciones registradas", style: TextStyle(fontSize: 20.0, fontFamily: "bold",),),
    );

    _showAlertDialog(BuildContext context, DocumentSnapshot ds) {
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
                        (CupertinoIcons.delete),
                        color: Colors.red,
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
            content: Text('¿Está seguro de borrar ${ds['app-name']}?', style: TextStyle(fontFamily: "regular", fontSize: 16)),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                /// This parameter indicates this action is the default,
                /// and turns the action's text to bold text.
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No', style: TextStyle(fontFamily: "regular", color: Colors.black),),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  ds.reference.delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Aplicación borrada exitosamente!")),
                  );
                  Navigator.pop(context);
                },
                isDestructiveAction: true,
                child: const Text('Borrar', style: TextStyle(fontFamily: "bold", color: Colors.red)),
              ),
            ],
          )
      );
    }


    return Scaffold(
        appBar: AppBar(
          elevation: 0.4,
          shadowColor: Color(0xFF666666),
          backgroundColor: Colors.white,
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
          children: [
            name,
            Container(margin: EdgeInsets.only(top: 60.0, left: 15.0, right: 15.0, bottom: 110.0),
                child:
                StreamBuilder<QuerySnapshot>(
                  stream: _db.collection('/aplicaciones_registradas/').doc(userID).collection(userID).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index)  {
                        DocumentSnapshot ds = snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                        return ListTile(
                          leading: FutureBuilder<String>(
                            future: desencriptar(ds['app-logo']),
                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: ClipOval(
                                    child: Image(
                                      width: 40,
                                      height: 40,
                                      image: NetworkImage(snapshot.data!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                          title: FutureBuilder<String>(
                            future: desencriptar(ds['app-name']),
                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data!);
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                          subtitle: FutureBuilder<String>(
                            future: desencriptar(ds['user-email']),
                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data!);
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            if (ds['entrega'] == 'QR') {
                              escaneoqr(context);
                            } else if (ds['entrega'] == "NUMERICO"){
                              sms(context);
                            }
                            // Do something when the tile is tapped
                          },
                          onLongPress: () {
                            _showAlertDialog(context, ds);
                          },
                        );

                      },
                    );
                  },
                ),
            ),
            //textoParaUsuario,
            /*Container(
              margin: EdgeInsets.only(top: 60.0, left: 15.0, right: 15.0),
              child: ListView(
                children: [
                  ListTile(
                    title: Text("Página del QR"),
                    trailing: Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QREscaneoOTP(imei_identifier: '58C9E829-EA16-44B5-820F-879B56BE0E97',)),);
                    },
                  ),
                  ListTile(
                    title: Text("Página del correo electrónico"),
                    trailing: Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CorreoElectronico()),);
                    },
                  ),
                  ListTile(
                    title: Text("Página de los SMS"),
                    trailing: Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SMS()),);
                    },
                  ),
                  ListTile(
                    title: Text("Página de Envio exitoso"),
                    trailing: Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmacionEnvio()),);
                    },
                  ),
                  ListTile(
                    title: Text("Página de Error de envio"),
                    trailing: Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmacionError()),);
                    },
                  ),
                ],
              ),
            ),*/
          ],
        ),

        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () {QRRegistroApplicacion(context);},
          icon: Icon(CupertinoIcons.qrcode_viewfinder, size: 30.0,),
          label: Text('Registrar', style: TextStyle(fontFamily: 'medium', fontSize: 14),),
        //),
      ),
    );


  }
}

Future<String> getIMEINumber() async {
  String imeiNo = await DeviceInformation.deviceIMEINumber;
  return imeiNo;
}

