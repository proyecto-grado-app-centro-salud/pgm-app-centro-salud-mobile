class DocumentosService {
  List filtrarDocumentosPorDiagnosticoPresuntivo(
      List documentos, String diagnosticoPresuntivo) {
    List documentosRetornar;
    List documentosFiltrados = documentos;
    if (diagnosticoPresuntivo != '') {
      documentosFiltrados = documentosFiltrados.where((element) {
        return element.diagnosticoPresuntivo
            .toLowerCase()
            .contains(diagnosticoPresuntivo.toLowerCase());
      }).toList();
    }
    documentosRetornar = documentosFiltrados;
    if (diagnosticoPresuntivo == '') {
      documentosRetornar = documentos;
    }
    return documentosRetornar;
  }
}
