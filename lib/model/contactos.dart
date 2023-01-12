final String tableContactos = 'contactos';

class ContactosFields {
  static final List<String> values = [
    /// Add all fields
    id, nombres, apellidos, parentesco, correo, telefono
  ];
  static final String id = '_id';
  static final String nombres = '_nombres';
  static final String apellidos = '_apellidos';
  static final String parentesco = '_parentesco';
  static final String correo = '_correo';
  static final String telefono = '_telefono';
}

class Contactos {
  final int? id;
  final String nombres;
  final String apellidos;
  final String parentesco;
  final String correo;
  final String telefono;

  const Contactos({
    this.id,
    required this.nombres,
    required this.apellidos,
    required this.parentesco,
    required this.correo,
    required this.telefono,
  });

  Contactos copy(
          {int? id,
          String? nombres,
          String? apellidos,
          String? parentesco,
          String? correo,
          String? telefono}) =>
      Contactos(
          id: id ?? this.id,
          nombres: nombres ?? this.nombres,
          apellidos: apellidos ?? this.apellidos,
          parentesco: parentesco ?? this.parentesco,
          correo: correo ?? this.correo,
          telefono: telefono ?? this.telefono);

  static Contactos fromJson(Map<String, Object?> json) => Contactos(
        id: json[ContactosFields.id] as int,
        nombres: json[ContactosFields.nombres] as String,
        apellidos: json[ContactosFields.apellidos] as String,
        parentesco: json[ContactosFields.parentesco] as String,
        correo: json[ContactosFields.correo] as String,
        telefono: json[ContactosFields.telefono] as String,
      );

  Map<String, Object?> toJson() => {
        ContactosFields.id: id,
        ContactosFields.nombres: nombres,
        ContactosFields.apellidos: apellidos,
        ContactosFields.parentesco: parentesco,
        ContactosFields.correo: correo,
        ContactosFields.telefono: telefono,
      };
}
