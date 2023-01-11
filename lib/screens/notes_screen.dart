import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:contactos/db/notes_database.dart';
import 'package:contactos/model/Contacto.dart';
import 'package:contactos/widget/note_card_widget.dart';
import 'package:contactos/screens/note_detail_screen.dart';


class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<contacto> contactos;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    ContactosDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
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
      actions: [Icon(Icons.search), SizedBox(width: 12)],
    ),
    body: Center(
      child: isLoading
          ? CircularProgressIndicator()
          : contactos.isEmpty
          ? Text(
        'No hay Contactos',
        style: TextStyle(color: Colors.white, fontSize: 24),
      )
          : buildNotes(),
    )
  );

  //Widget editButton() => IconButton(
  //    icon: Icon(Icons.edit_outlined),
  //    onPressed: () async {
  //      if (isLoading) return;
//
  //      await Navigator.of(context).push(MaterialPageRoute(
  //        builder: (context) => AddEditNoteP age(note: note),
  //      ));
//
  //      refreshNote();
  //    });
  Widget buildNotes() => StaggeredGridView.countBuilder(
    padding: EdgeInsets.all(8),
    itemCount: contactos.length,
    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      final note = contactos[index];

      return GestureDetector(
        child: NoteCardWidget(note: note, index: index),
      );
    },
  );
}