class Actividades {
  int duracion;
  String titulo;

  Actividades(this.titulo, this.duracion);

  Map<String, dynamic> toMap() {
    return {
      'Titulo': titulo,
      'Duracion': duracion.toString(),
    };
  }
}
