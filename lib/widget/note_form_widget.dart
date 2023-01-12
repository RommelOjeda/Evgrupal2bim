import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? name;
  final String? last;
  final String? relation;
  final String? mail;
  final String? cel;

  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedLast;
  final ValueChanged<String> onChangedRelation;
  final ValueChanged<String> onChangedMail;
  final ValueChanged<String> onChangedCel;


  const NoteFormWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.name = '',
    this.last = '',
    this.relation= '',
    this.mail= '',
    this.cel= '',

    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedName,
    required this.onChangedLast,
    required this.onChangedRelation,
    required this.onChangedMail,
    required this.onChangedCel,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Switch(
                value: isImportant ?? false,
                onChanged: onChangedImportant,
              ),
              Expanded(
                child: Slider(
                  value: (number ?? 0).toDouble(),
                  min: 0,
                  max: 5,
                  divisions: 5,
                  onChanged: (number) => onChangedNumber(number.toInt()),
                ),
              )
            ],
          ),
          buildNombre(),
          SizedBox(height: 8),
          buildApellido(),
          buildParentesco(),
          buildCorreo(),
          buildCelular(),
          SizedBox(height: 16),
        ],
      ),
    ),
  );

  Widget buildNombre() => TextFormField(
    maxLines: 1,
    initialValue: name,
    style: TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Nombre',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (name) =>
    name != null && name.isEmpty ? 'El Nombre no debe estar vacio' : null,
    onChanged: onChangedName,
  );

  Widget buildApellido() => TextFormField(
    maxLines: 1,
    initialValue: last,
    style: TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Apellido',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (last) =>
    last != null && last.isEmpty ? 'Apellido' : null,
    onChanged: onChangedLast,
  );

  Widget buildParentesco() => TextFormField(
    maxLines: 1,
    initialValue: relation,
    style: TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Parentesco',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (relation) =>
    relation != null && relation.isEmpty ? 'Parentesco' : null,
    onChanged: onChangedRelation,
  );

  Widget buildCorreo() => TextFormField(
    maxLines: 1,
    initialValue: mail,
    style: TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Correo',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (mail) =>
    mail != null && mail.isEmpty ? 'Correo' : null,
    onChanged: onChangedMail,
  );

  Widget buildCelular() => TextFormField(
    maxLines: 1,
    initialValue: cel,
    style: TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Celular',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (cel) =>
    cel != null && cel.isEmpty ? 'Celular' : null,
    onChanged: onChangedCel,
  );


  /*
  Widget buildDescription() => TextFormField(
    maxLines: 5,
    initialValue: description,
    style: TextStyle(color: Colors.white60, fontSize: 18),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Descrioción de la nota...',
      hintStyle: TextStyle(color: Colors.white60),
    ),
    validator: (title) => title != null && title.isEmpty
        ? 'La descripción no puede estar bacia'
        : null,
    onChanged: onChangedDescription,
  );
   */

}