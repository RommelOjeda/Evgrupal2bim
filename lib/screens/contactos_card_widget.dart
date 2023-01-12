import 'package:contactos/model/contactos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _lightColors = [Colors.blue[800], Colors.purple[900]];

class ContactosCardWidget extends StatelessWidget {
  ContactosCardWidget({
    Key? key,
    required this.contacto,
    required this.index,
  }) : super(key: key);

  final Contactos contacto;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    return Container(
      color: _lightColors[index % _lightColors.length],
      child: ListTile(
        title: Text(contacto.nombres + " " + contacto.apellidos,
            style: TextStyle(color: Colors.white)),
        subtitle: Text(
          "Telefono: " + contacto.telefono + " email: " + contacto.correo,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
