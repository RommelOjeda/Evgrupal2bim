final String tableContactos = 'user';

class ContactoFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, number,nombre,apellido, parentesco,correo,celular
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String nombre = 'nombre';
  static final String apellido = 'apellido';
  static final String parentesco = 'parentesco';
  static final String correo = 'correo';
  static final String celular = 'celular';
}

class contacto {
  final int? id;
  final bool isImportant;
  final String nombre;
  final String apellido;
  final String parentesco;
  final String correo;
  final String celular;

  const contacto({
    this.id,
    required this.isImportant,
    required this.nombre,
    required this.apellido,
    required this.parentesco,
    required this.correo,
    required this.celular,
  });



  contacto copy({
    int? id,
    bool? isImportant,
    int? number,
    String? nombre,
    String? apellido,
    String? parentesco,
    String? correo,
    String? celular,
  }) =>
      contacto(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        nombre: nombre ?? this.nombre,
        apellido: apellido ?? this.apellido,
        parentesco: parentesco ?? this.parentesco,
        correo: correo ?? this.correo,
        celular: celular ?? this.celular,
      );

  static contacto fromJson(Map<String, Object?> json) => contacto(
        id: json[ContactoFields.id] as int?,
         isImportant: json[ContactoFields.isImportant] == 1,
        nombre: json[ContactoFields.nombre] as String,
        apellido: json[ContactoFields.apellido] as String,
        parentesco: json[ContactoFields.parentesco] as String,
        correo: json[ContactoFields.correo] as String,
        celular: json[ContactoFields.celular] as String,
      );

  Map<String, Object?> toJson() => {
        ContactoFields.id: id,
        ContactoFields.isImportant: isImportant ? 1 : 0,
        ContactoFields.apellido: apellido,
        ContactoFields.celular:celular,
        ContactoFields.nombre: nombre,
        ContactoFields.parentesco: parentesco,
        ContactoFields.correo: correo,
      };
}
