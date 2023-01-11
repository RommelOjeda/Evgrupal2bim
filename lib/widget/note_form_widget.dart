import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final String? categoria;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedcategoria;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    this.categoria= '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedcategoria,

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
          buildTitle(),
          SizedBox(height: 8),
          buildCategoria(),
          buildDescription(),
          SizedBox(height: 16),
        ],
      ),
    ),
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    style: TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Título',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'El título no debe estar bacio' : null,
    onChanged: onChangedTitle,
  );

  Widget buildCategoria() => TextFormField(
    maxLines: 1,
    initialValue: categoria,
    style: TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Categoria',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (categoria) =>
    categoria != null && categoria.isEmpty ? 'Categoria' : null,
    onChanged: onChangedcategoria,
  );

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
}