import 'package:contactos/db/contactos_database.dart';
import 'package:contactos/model/contactos.dart';
import 'package:contactos/screens/add_edit_contactos.dart';
import 'package:contactos/screens/contactos_card_widget.dart';
import 'package:flutter/material.dart';

class ContactosPage extends StatefulWidget {
  @override
  _ContactosPageState createState() => _ContactosPageState();
}

class _ContactosPageState extends State<ContactosPage> {
  late List<Contactos> contactos;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshContactos();
  }

  @override
  void dispose() {
    ContactosDatabase.instance.close();

    super.dispose();
  }

  Future refreshContactos() async {
    setState(() => isLoading = true);

    this.contactos = await ContactosDatabase.instance.readAllContactos();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(
          'Contactos',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : contactos.isEmpty
                ? Text(
                    'No hay contactos',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )
                : buildContactos(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.person),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddEditContactos()),
          );
          refreshContactos();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  Widget buildContactos() => ListView.builder(
        itemCount: contactos.length,
        itemBuilder: (BuildContext context, int index) {
          final contacto = contactos[index];
          return ContactosCardWidget(contacto: contacto, index: index);
        },
      );
}
