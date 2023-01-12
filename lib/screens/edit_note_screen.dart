import 'package:flutter/material.dart';
import 'package:contactos/db/notes_database.dart';
import 'package:contactos/model/Contacto.dart';
import 'package:contactos/widget/note_form_widget.dart';

class AddEditNotePage extends StatefulWidget {
  final contacto? note;

  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late bool? isImportant;
  late String? name;
  late String? last;
  late String? relation;
  late String? mail;
  late String? cel;

  @override
  void initState() {
    super.initState();
    isImportant = widget.note?.isImportant ?? false;
    name = widget.note?.nombre ?? '';
    last = widget.note?.apellido ?? '';
    relation =widget.note?.parentesco ?? '';
    mail =widget.note?.correo ?? '';
    cel =widget.note?.celular ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: NoteFormWidget(
        isImportant: isImportant,
        name: name,
        last: last,
        relation: relation,
        mail: mail,
        cel: cel,
        onChangedImportant: (isImportant) =>
            setState(() => this.isImportant = isImportant),
        onChangedName: (name) => setState(() => this.name = name),
        onChangedLast: (last) => setState(() => this.last = last),
        onChangedRelation: (description) =>
            setState(() => this.relation = relation),
        onChangedMail: (mail) => setState(() => this.mail = mail),
        onChangedCel: (cel) => setState(() => this.cel = cel),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = name!.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: Text('Guardar'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      nombre: name,
      apellido: last,
      parentesco: relation,
      correo: mail,
      celular: cel,
    );

    await ContactosDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = contacto(
      isImportant: true,
      nombre: ContactoFields.nombre,
      apellido: ContactoFields.apellido,
      parentesco: ContactoFields.parentesco,
      correo: ContactoFields.correo,
      celular: ContactoFields.celular,
    );

    await ContactosDatabase.instance.create(note);
  }
}