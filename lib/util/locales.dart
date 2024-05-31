import 'package:flutter_localization/flutter_localization.dart';

List<MapLocale> LOCALES = [
  const MapLocale('es', LocaleData.es),
  const MapLocale('ay', LocaleData.ay),
  const MapLocale('quechua', LocaleData.quechua),
  const MapLocale('guarani', LocaleData.guarani),
];

mixin LocaleData {
  static const String especialidades = 'Especialidades';
  static const String equipoMedico = 'Equpo medico';
  static const String informacionProcesoObtencionFichaMedicaPresencial =
      'Informacion proceso obtencion ficha presencial';

  static const String verTodo = 'Ver todo';

  static const Map<String, dynamic> es = {
    especialidades: 'Especialidades',
  };
  static const Map<String, dynamic> ay = {
    especialidades: 'Allinllachu',
  };
  static const Map<String, dynamic> quechua = {
    especialidades: 'Allinllachu',
  };
  static const Map<String, dynamic> guarani = {
    especialidades: 'Maitei',
  };
}
