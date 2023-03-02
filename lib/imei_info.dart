import 'package:flutter/material.dart';
import 'package:device_information/device_information.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'qr_escaneo_otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main () {
  runApp(IMEI_Info());
}

class IMEI_Info extends StatefulWidget {
  @override
  _IMEI_InfoState createState() => _IMEI_InfoState();

}

class _IMEI_InfoState extends State<IMEI_Info>{
  String _imeiNo = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    late String imeiNo = '';
    // Platform messages may fail,
    // so we use a try/catch PlatformException.
    try {
      imeiNo = await DeviceInformation.deviceIMEINumber;
    } on PlatformException catch (e) {
      imeiNo = '${e.message}';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _imeiNo = imeiNo;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('imei_number', _imeiNo);

    //QREscaneoOTP(imei_identifier: _imeiNo);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Device Information Plugin Example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('IMEI Number: $_imeiNo\n'),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}