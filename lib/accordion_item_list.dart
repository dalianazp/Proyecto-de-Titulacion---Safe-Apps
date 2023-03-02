import 'package:flutter/material.dart';
import 'accordion_preguntas_frecuentes.dart';

class AccordionItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Accordion(
          title: '¿Qué es un doble factor de autenticación?',
          content:
          'El doble factor de autenticación o Two-Factor Authentication (2FA), en inglés, es un proceso de autenticación que utiliza dos formas de identificación para verificar la identidad del usuario',
        ),
        Accordion(
          title: '¿Cómo funciona el doble factor de autenticación?',
          content:
          'Requiere dos formas de identificación. Por lo general, una es una contraseña o PIN y la otra es algo que el usuario tiene en su poder, como un token o un dispositivo de autenticación.',
        ),
        Accordion(
            title: '¿Cómo registro una aplicación?',
            content:
            'Para registrar una aplicación deberá activar el doble factor de autenticación en el prototipo web, lo que le proporcionará un código QR, que podrá escanear y utilizar para registrar su aplicación.'),
        Accordion(
            title: '¿Cómo borro una aplicación?',
            content:
            'Para borrar una aplicación mantenga presionado sobre la aplicación que desea eliminar y se le mostrará un mensaje de confirmación de borrado. Se recomienda no borrar sus aplicaciones para mantener la seguridad de la cuenta.'),
        Accordion(
          title: '¿Qué es OTP?',
          content:
          'OTP significa "One-Time Password" o "Contraseña de un solo uso" en español. Es un código de seguridad que se utiliza para confirmar la identidad de un usuario.',
        ),
        Accordion(
          title: '¿Cómo genero un OTP en la aplicación?',
          content:
          'El prototipo web genera un OTP automáticamente después del inicio de sesión.',
        ),
        Accordion(
            title: '¿Qué son los métodos de entrega?',
            content:
            'Los métodos de entrega son la vía por la cual usted desea recibir los OTPs, puede ser SMS, correo electrónico, a través del prototipo web en forma de QR, entre otros.'),
      ],
    );
  }
}